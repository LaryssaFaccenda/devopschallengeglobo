from fastapi import FastAPI
from fastapi.responses import PlainTextResponse
from datetime import datetime
import redis
import os

app = FastAPI()

# Conectando-se ao Memorystore (Redis)
redis_host = "10.100.120.115" #ip adquirido depois da criação do Redis
redis_port = 6379  # Porta padrão do Redis
cache = redis.StrictRedis(host=redis_host, port=redis_port, db=0, decode_responses=True)

@app.get("/texto")
def hello():
    # Verifica se a resposta já está em cache
    cached_response = cache.get("hello_response")
    if cached_response:
        return PlainTextResponse(cached_response, headers={"Cache-Control": "public, max-age=10"})
    
    # Se não estiver em cache, cria a resposta e armazena no cache
    response = "Olá do app Python!"
    cache.setex("hello_response", 10, response)  # Cache por 10 segundos
    return PlainTextResponse(response, headers={"Cache-Control": "public, max-age=10"})

@app.get("/horario")
def time():
    # Verifica se a resposta da hora já está em cache
    cached_time = cache.get("time_response")
    if cached_time:
        return PlainTextResponse(cached_time, headers={"Cache-Control": "public, max-age=10"})
    
    # Se não estiver em cache, cria a resposta da hora e armazena no cache
    now = datetime.utcnow().isoformat()
    response = f"Hora UTC: {now}"
    cache.setex("time_response", 10, response)  # Cache por 10 segundos
    return PlainTextResponse(response, headers={"Cache-Control": "public, max-age=10"})
