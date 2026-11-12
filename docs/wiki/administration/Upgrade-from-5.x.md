# Upgrade from 5.x

VRT 6.0 moves the bundled database to PostgreSQL 18. Plan a short downtime.
Upgrade UI and API together. Run the commands in the VRT folder (Linux, macOS or WSL).

## Before you start

- Keep your old `.env` and `docker-compose.yml` for a rollback.
- Guests or untrusted users on 5.x? Read the Security section of the 6.0.0 release notes.
  - Change passwords of users who approved baselines.
  - Ask them to **Regenerate** their API keys ([Profile and API key](Profile-and-API-key)).

## Steps

1. Dump the database while 5.x is installed:

   ```sh
   docker compose stop ui api
   docker compose exec -T postgres sh -c 'pg_dump -U "$POSTGRES_USER" -Fc "$POSTGRES_DB"' > vrt-pg12.dump
   docker compose down && mv db db-pg12
   ```

   PostgreSQL 18 cannot read a PostgreSQL 12 data folder. This applies to the bundled `postgres` only.

2. Take the 6.0 `docker-compose.yml` and `.env` and carry over your values.
   - New variables are commented out with defaults: [Configuration](Configuration).
   - Set `JWT_SECRET` (`openssl rand -hex 32`).
   - Change `DEFAULT_USER_PASSWORD` and `DEFAULT_USER_API_KEY` if still samples.

3. Restore into PostgreSQL 18:

   ```sh
   docker compose up -d --wait postgres
   docker compose exec -T postgres sh -c 'pg_restore -U "$POSTGRES_USER" -d "$POSTGRES_DB" --exit-on-error' < vrt-pg12.dump
   ```

4. On Linux: `sudo chown -R 1000:1000 ./imageUploads ./ssl`.

5. Start 6.0: `docker compose pull && docker compose up -d`.

6. Check:
   - `docker compose logs migration` ends with "All migrations have been successfully applied".
   - The UI help menu shows 6.0.0.
   - Then delete `./db-pg12` and `vrt-pg12.dump`.

## Rollback

1. `docker compose down`
2. `mv db db-new && mv db-pg12 db`
3. Put back the old `.env` and `docker-compose.yml`.
4. `docker compose up -d`

Anything written on 6.0 is lost.

## What changes for you

- **Everyone signs in again once.** SDK and agent API keys keep working.
- **No public signing key.** The API needs your own `JWT_SECRET`.
- **The API runs as user id 1000.** Kubernetes: the image command is now `node dist/main`.
- **Live updates need a login.** UI 5.x gets none from API 6.0.
- **HTTP errors are 4xx** (`400`, `404`, `409`, `413`, `422`, `503`), not `200` or `500`.
- **Stricter uploads:**
  - Not a PNG: `400`.
  - Above `MAX_IMAGE_PIXELS`: `422`.
  - Body above `BODY_PARSER_JSON_LIMIT`: `413`.
- **Comparison results can change.** Some runs may get a different status.
- **Database connections use no TLS.** Add `?sslmode=require` to `DATABASE_URL` if needed.
- **The Merge branches panel is gone.** `POST /test-variations/merge` stays: [Variations and history](Variations-and-history).
- **The noise filter is now a hint.** It never changes a status and is off after the upgrade.
  - Switch it on in **Settings**, **Post-analysis**: [Noise hint](Noise-hint).
- **Docker Compose v2 is required.**

## Clients

5.x SDKs and agents keep working with 6.0. Use the latest 5.x release.
See [SDK / agent version](How-to-choose-right-SDK---agent-version).
