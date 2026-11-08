# Upgrade from 5.x

VRT 6.0 moves the bundled database to PostgreSQL 18 and changes a few defaults. Plan for a short downtime. Run the commands in the VRT folder, in a Linux, macOS or WSL shell.

Upgrade the UI and the API together: UI 6.0 needs API 6.0.

## Before you start

- Keep your old `.env` and `docker-compose.yml`; you need them for a rollback.
- If guests or untrusted users could sign in to your 5.x, read the Security section of the 6.0.0 release notes: change the passwords of users who approved baselines and have them **Regenerate** their API keys ([Profile and API key](Profile-and-API-key)).

## Steps

1. **Dump the database** while 5.x is still installed. Stop the UI and the API first so nothing is written after the dump:

   ```
   docker compose stop ui api
   docker compose exec -T postgres sh -c 'pg_dump -U "$POSTGRES_USER" -Fc "$POSTGRES_DB"' > vrt-pg12.dump
   docker compose down && mv db db-pg12
   ```

   PostgreSQL 18 cannot read a PostgreSQL 12 data folder. Without the dump it refuses to start and leaves `./db` untouched. This applies only to the bundled `postgres` service.

2. Take the new `docker-compose.yml` and `.env` from the 6.0 release and carry over your values. New variables are commented out with their defaults ([Configuration](Configuration)). Set `JWT_SECRET` to a random value (`openssl rand -hex 32`), and change `DEFAULT_USER_PASSWORD` and `DEFAULT_USER_API_KEY` if they are still the samples.

3. **Restore** into PostgreSQL 18:

   ```
   docker compose up -d --wait postgres
   docker compose exec -T postgres sh -c 'pg_restore -U "$POSTGRES_USER" -d "$POSTGRES_DB" --exit-on-error' < vrt-pg12.dump
   ```

4. On Linux, give the images and TLS files to the API's user: `sudo chown -R 1000:1000 ./imageUploads ./ssl`. Not needed on macOS with Docker Desktop.

5. `docker compose pull && docker compose up -d`. The `migration` service applies the new migrations; the `api` waits for it.

6. Check that `docker compose logs migration` ends with "All migrations have been successfully applied" and that the UI shows 6.0.0 in the help menu. Then delete `./db-pg12` and `vrt-pg12.dump`.

**Rollback:** `docker compose down`, `mv db db-new && mv db-pg12 db`, put back the old `.env` and `docker-compose.yml`, `docker compose up -d`. Anything written on 6.0 is lost.

## What changes for you

- **Everyone signs in again once.** Tokens from 5.x are not accepted. API keys of your SDKs and agents keep working.
- **No public signing key.** The API refuses to start without your own `JWT_SECRET`.
- **The API runs as user id 1000.** Check the `chown` step and, if you override `command` or `entrypoint` (Kubernetes), the image's command, which is now `node dist/main`.
- **Live updates need a login.** A UI 5.x gets no live updates from API 6.0. While a 5.x UI must keep working, set `WS_AUTH_REQUIRED=false` and `WS_BROADCAST=true`, and remove both once every UI runs 6.0.
- **HTTP errors are 4xx** (`400`, `404`, `409`, `413`, `422`, `503`) instead of `200` or `500`. Check custom clients that treated any `2xx` as success.
- **Stricter uploads:** a screenshot that is not a PNG gets `400`; above `MAX_IMAGE_PIXELS` it gets `422`; a request body above `BODY_PARSER_JSON_LIMIT` gets `413`.
- **Comparison results can change.** The project's comparison settings are applied on top of the defaults and the comparators were fixed. Expect some runs to get a different status after the upgrade.
- **Database connections use no TLS** unless `DATABASE_URL` contains `sslmode`. If your database needs TLS, add `?sslmode=require`.
- **The Merge branches panel is gone** from the UI. The API call `POST /test-variations/merge` stays ([Variations and history](Variations-and-history)).
- **The rendering-noise check replaces the earlier noise filter** of the 6.0 release candidates. It is a hint that never changes a status, and it is off for projects created after the upgrade. Existing projects keep it on; switch it off in **Settings** → **Post-analysis**. See [Noise hint](Noise-hint).
- **Docker Compose v2 is required.**

## Clients

SDKs and agents of version 5.x keep working with 6.0. Newer 5.x releases fix bugs and handle 6.0's statuses and error codes; see [How to choose the right SDK / agent version](How-to-choose-right-SDK---agent-version).
