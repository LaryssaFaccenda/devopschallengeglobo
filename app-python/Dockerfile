FROM python:3.11-slim

WORKDIR /app
COPY . .

EXPOSE 8080

RUN pip install fastapi uvicorn redis

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
