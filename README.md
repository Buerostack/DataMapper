# DataMapper

DataMapper turns **Handlebars `.hbs` DSL files** into **REST endpoints**. Place DSLs under `DSL/<project>/<view>.hbs` and call them with `POST /<project>/<view>`.

**Intent.** DataMapper shapes and normalizes payloads, so consumers (e.g., UIs) receive **ready‑to‑use data** without extra client‑side processing. It also acts as a **contract layer** between back‑end services, harmonizing formats and protocols from different providers. It’s an **architecturally important**, generic component rather than custom application logic.

## Origin

Originally developed and maintained at the **Information System Authority of Estonia** (Riigi Infosüsteemi Amet, RIA) since June 2018. Design and development led by [Rainer Türner](https://www.linkedin.com/in/rainer-t%C3%BCrner-aba66274/) until April 2025.

**Original repository:** https://github.com/buerokratt/DataMapper

## Ownership

This cleaned repository is maintained by **Rainer Türner** starting from September 24, 2025, with an intention to have a clean version of DataMapper to work on, without affecting its owner RIA.

---

## Quick start (Docker Compose v2)

```bash
git clone https://github.com/Buerostack/DataMapper.git
cd DataMapper
docker compose up -d --build datamapper
```

Health check:

```bash
curl -sS http://localhost:3000/healthz
```

---

## Live development (mount DSLs)

`docker-compose.yml` mounts `./DSL` into the container, so template edits apply immediately.

```bash
docker compose restart datamapper
```

---

## Call a DSL

**File:** `DSL/samples/ping.hbs`  
**URL:** `POST /samples/ping`

```bash
curl -sS -X POST http://localhost:3000/samples/ping   -H 'Content-Type: application/json'   -H 'type: json'   -d '{}'
```

> Tip: If you prefer not to send `type: json`, set `Accept: application/json` or make your template output valid JSON—DataMapper returns JSON automatically when possible.

---

## Project layout

```
DSL/
  └─ <project>/
       ├─ <view>.hbs           # POST /<project>/<view>
       └─ hbs/<view>.hbs       # optional fallback path
lib/
  └─ helpers.js                # Handlebars helpers (e.g., {{now}}, {{{json obj}}})
server.js                      # Express + Handlebars glue
Dockerfile
docker-compose.yml
```

---

## Useful commands

**Rebuild the image (refresh base image too):**
```bash
docker compose build --pull datamapper
```

**Start / Stop:**
```bash
docker compose up -d datamapper
docker compose down
```

**Logs:**
```bash
docker compose logs -f datamapper
```

**Shell inside the container:**
```bash
docker exec -it datamapper sh
```

---

## Troubleshooting

- **“Cannot POST /…​”** → The route didn’t match or the template path is wrong. Ensure the file exists at `DSL/<project>/<view>.hbs`.
- **`TemplateNotFound`** → Filename/paths don’t match the URL (no extension in the URL).
- **`TemplateOutputNotJson`** → You requested JSON but the template doesn’t render valid JSON. Fix the template or omit the JSON preference header.
