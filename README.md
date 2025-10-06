# tfplan-viewer

A simple tool for visualizing and analyzing Terraform plan files.

## Features

- Hosts a simple web app to show a html representation of a terraform plan that has been parsed by Azure AI
- Provides a clear, human-readable summary of changes
- Highlights resource additions, deletions, and modifications

## Getting Started

### Prerequisites

- Python

### Installation

Clone the repository:

```bash
git clone https://github.com/hmcts/tfplan-viewer.git
```

Install dependencies (if applicable):

```bash
pip install -r requirements.txt
```

### Usage

1. Provide a storage account name and key or SAS via an environment variable:

```bash
export AZURE_STORAGE_ACCOUNT=mystorageaccount
export AZURE_STORAGE_KEY=mystoragekey
```

2. Run the viewer:

    ```bash
    python -m uvicorn tfplan-viewer:app --reload
    ```