# Dockerfile
FROM python:3.14-slim
WORKDIR /app
COPY requirements.txt /app
RUN pip install -r requirements.txt
COPY tfplan-viewer.py /app
ENV HOST=0.0.0.0 PORT=8080
EXPOSE 8080
CMD ["uvicorn", "tfplan-viewer:app", "--host", "0.0.0.0", "--port", "8080"]