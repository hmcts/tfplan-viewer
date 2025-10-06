import os, time, datetime
from fastapi import FastAPI, HTTPException
from fastapi.responses import HTMLResponse, PlainTextResponse, JSONResponse
from azure.storage.blob import BlobServiceClient
from azure.identity import DefaultAzureCredential
from functools import lru_cache

ORG = os.environ.get("ORG", "hmcts")
ACCOUNT = os.environ["AZURE_STORAGE_ACCOUNT"]
CONTAINER = os.environ.get("AZURE_STORAGE_CONTAINER", "plan-html")
PATTERN = os.environ.get("AZURE_STORAGE_PR_PATH_PATTERN", "{org}/{repo}/{pr}/plan.html")
TTL = int(os.environ.get("CACHE_TTL_SECONDS", "60"))
INDEX_TTL = int(os.environ.get("INDEX_CACHE_TTL_SECONDS", "300"))
USE_MI = os.environ.get("USE_MANAGED_IDENTITY", "false").lower() == "true"

if USE_MI:
    credential = DefaultAzureCredential(exclude_interactive_browser_credential=True)
    bsc = BlobServiceClient(f"https://{ACCOUNT}.blob.core.windows.net", credential=credential)
else:
    sas = os.environ.get("AZURE_STORAGE_SAS")
    key = os.environ.get("AZURE_STORAGE_KEY")
    if sas:
        bsc = BlobServiceClient(f"https://{ACCOUNT}.blob.core.windows.net{sas}")
    elif key:
        bsc = BlobServiceClient(f"https://{ACCOUNT}.blob.core.windows.net", credential=key)
    else:
        raise RuntimeError("Provide SAS, key, or set USE_MANAGED_IDENTITY=true")

container_client = bsc.get_container_client(CONTAINER)
app = FastAPI(title="Terraform Plan Viewer")

_cache = {}  # blob content cache
_index_cache = {"t": 0, "data": None}  # repos/prs index cache

def get_blob_path(repo: str, pr: int):
    path = PATTERN.format(org=ORG, repo=repo, pr=pr)
    # Normalize any accidental leading slashes
    if path.startswith('/'):
        path = path.lstrip('/')
    return path

def fetch_html(blob_path: str) -> str:
    now = time.time()
    entry = _cache.get(blob_path)
    if entry and now - entry["t"] < TTL:
        return entry["d"]
    try:
        data = container_client.download_blob(blob_path).readall().decode("utf-8")
    except Exception as e:
        raise HTTPException(404, detail={
            "error": "Not found",
            "blobPath": blob_path,
            "hint": "Verify the blob exists and the path matches hmcts/<repo>/<pr>/plan.html",
            "exception": str(e)
        })
    _cache[blob_path] = {"d": data, "t": now}
    return data

def build_index(force: bool = False):
    now = time.time()
    if not force and _index_cache["data"] and (now - _index_cache["t"]) < INDEX_TTL:
        return _index_cache["data"]
    repos: dict[str, set[int]] = {}
    prefix = "hmcts/"
    # List blobs under hmcts/; expect pattern hmcts/<repo>/<pr>/plan.html
    for blob in container_client.list_blobs(name_starts_with=prefix):
        name = blob.name
        if not name.endswith('/plan.html'):
            continue
        parts = name.split('/')
        # parts: hmcts, repo, pr, plan.html
        if len(parts) != 4:
            continue
        _, repo, pr_str, fname = parts
        if not pr_str.isdigit():
            continue
        pr = int(pr_str)
        repos.setdefault(repo, set()).add(pr)
    index = {
        "generatedAt": datetime.datetime.utcnow().isoformat() + 'Z',
        "repos": {r: [str(p) for p in sorted(prs, reverse=True)] for r, prs in sorted(repos.items())}
    }
    _index_cache["data"] = index
    _index_cache["t"] = now
    return index

@app.get("/health", response_class=PlainTextResponse)
def health():
    return "ok"

@app.get("/{repo}/{pr}", response_class=HTMLResponse)
def get_plan(repo: str, pr: int):
    blob_path = get_blob_path(repo, pr)
    html = fetch_html(blob_path)
    return HTMLResponse(content=html)

@app.get("/", response_class=PlainTextResponse)
def root():
    return (
        "Terraform Plan Viewer\n"
        f"Org (implicit): {ORG}\n"
        "Usage: GET /{repo}/{pr})\n"
    )