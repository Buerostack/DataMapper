# DataMapper (clean)

Minimal, generic DataMapper using Handlebars.

## Run (Compose v2)
docker compose up -d --build datamapper
curl -sS http://localhost:3000/healthz
curl -sS -X POST http://localhost:3000/samples/ping -H 'Content-Type: application/json' -H 'type: json' -d '{}'
