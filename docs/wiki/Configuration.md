# Configuration

VRT is configured with the `.env` file next to `docker-compose.yml`. Compose passes the values on to the containers. After a change, run `docker compose up -d` again. Settings in a section below that are commented out in `.env` use the default shown.

## Required

| Variable | Meaning |
|---|---|
| `JWT_SECRET` | Key that signs login tokens. The API does not start without it, and refuses the old public sample value `jwtPrivateKey`. Generate one with `openssl rand -hex 32`. Changing it signs everyone out once. |

## Addresses and ports

| Variable | Default | Meaning |
|---|---|---|
| `REACT_APP_API_URL` | `http://localhost:4200` | URL of the API as the browser sees it. |
| `APP_FRONTEND_URL` | `http://localhost:8080` | URL of the UI. |
| `PORT` | `8080` | Host port of the UI. |
| `APP_PORT` | `4200` | Host port of the API. |

## Versions

`VRT_UI_VERSION`, `VRT_API_VERSION` and `VRT_MIGRATION_VERSION` pick the image tags. Use the same version for all three. `VRT_DINOV2_VERSION` is for the optional DINOv2 service.

## Database

`POSTGRES_PORT`, `POSTGRES_USER`, `POSTGRES_PASSWORD` and `POSTGRES_DB` configure the bundled PostgreSQL 18. The API and the migration service reach it through `DATABASE_URL`, which `docker-compose.yml` builds from these values; a `DATABASE_URL` in `.env` has no effect. For your own database, edit `DATABASE_URL` for `api` and for `migration` in `docker-compose.yml`, and add `?sslmode=require` if the connection must use TLS, because VRT 6.0 connects without TLS unless asked.

## First admin

`DEFAULT_USER_EMAIL`, `DEFAULT_USER_PASSWORD` and `DEFAULT_USER_API_KEY` create the first admin when the database is new. The sample values are public: change them before others can reach the server.

## Sessions and limits

| Variable | Default | Meaning |
|---|---|---|
| `JWT_LIFE_TIME` | `1d` | How long a login lasts. |
| `BODY_PARSER_JSON_LIMIT` | `5mb` in `.env` | Largest JSON body, such as a base64 screenshot. A bigger one gets an HTTP 413. |
| `MULTIPART_FILE_SIZE_LIMIT` | `104857600` (100 MB) | Largest multipart screenshot, in bytes. |
| `MAX_IMAGE_PIXELS` | `100000000` | Screenshots with more pixels are refused. |
| `REGISTRATION_ENABLED` | `true` | `false` hides sign-up. |
| `LOG_LEVEL` | empty | Comma-separated Nest log levels, for example `log,error,warn`. |
| `DIFF_WORKER_MAX_HEAP_MB` | `512` | Memory limit of each image-comparison worker, in MB. Raise it if large screenshots make workers run out of memory. |

## Image storage

Images go to `./imageUploads` by default. For Amazon S3 set `STATIC_SERVICE=s3` and `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_REGION` and `AWS_S3_BUCKET_NAME`.

The API runs as user id 1000, so on Linux `./imageUploads` and any TLS files must belong to it: `sudo chown -R 1000:1000 ./imageUploads ./ssl`.

To serve the API over HTTPS directly, mount a key and a certificate and point `HTTPS_KEY_PATH` and `HTTPS_CERT_PATH` at them (defaults `./secrets/ssl.key` and `./secrets/ssl.cert`; the sample `docker-compose.yml` has the mounts commented out). The API uses HTTPS only when both files exist.

## Sign-in

- **LDAP:** `LDAP_ENABLED=true` with `LDAP_URL`, `LDAP_BIND_USER`, `LDAP_BIND_PASSWORD`, `LDAP_SEARCH_DN`, `LDAP_USERS_SEARCH_FILTER`, `LDAP_ATTRIBUTE_MAIL`, `LDAP_ATTRIBUTE_FIRST_NAME`, `LDAP_ATTRIBUTE_LAST_NAME` and `LDAP_TLS_NO_VERIFY`.
- **SSO (OpenID Connect):** `OIDC_ENABLED=true` with `OIDC_ISSUER_URL`, `OIDC_CLIENT_ID`, `OIDC_CLIENT_SECRET` and `OIDC_REDIRECT_URI` (default `http://localhost:4200/users/oidc/callback`; no query string; register it at your identity provider). It takes precedence over LDAP and turns off password login and sign-up. Optional: `OIDC_SCOPES` (`openid profile email`), `OIDC_ATTRIBUTE_MAIL`, `OIDC_ATTRIBUTE_FIRST_NAME`, `OIDC_ATTRIBUTE_LAST_NAME`, `OIDC_ROLE_CLAIM` (`groups`), `OIDC_ADMIN_VALUES` (`vrt-admin,admin`; these values make a user an admin), `OIDC_DEFAULT_ROLE` (`editor`), `OIDC_REQUIRE_VERIFIED_EMAIL` (`true`), `OIDC_TLS_NO_VERIFY` (`false`). The role is updated from the identity provider on every login.
- `REACT_APP_OIDC_AUTO_REDIRECT=true` sends the sign-in page straight to the identity provider instead of showing **Login with SSO**.

## Live updates

| Variable | Default | Meaning |
|---|---|---|
| `WS_AUTH_REQUIRED` | `true` | Live-update connections need a login token. |
| `WS_BROADCAST` | `false` | `true` sends every event to every client instead of only to those viewing that project or build. |
| `REDIS_URL` | empty | Needed only with more than one API instance, so events reach clients on any instance. There is no Redis service in `docker-compose.yml`; add your own. |

A UI of version 5.x cannot use live updates with an API 6.0 unless you set `WS_AUTH_REQUIRED=false` and `WS_BROADCAST=true`.

## Rendering-noise check

See [Noise hint](Noise-hint). The blur stage needs nothing. The second stage needs the DINOv2 service:

1. Start it with `docker compose --profile dinov2 up -d`.
2. Uncomment `DINOV2_URL=http://dinov2:8000` in `.env`.

| Variable | Default | Meaning |
|---|---|---|
| `DINOV2_URL` | empty | Address of the DINOv2 service. Without it only the blur stage works. |
| `DINOV2_TIMEOUT_MS` | `60000` | How long the API waits for the service. |
| `DINOV2_MAX_PIXELS` | `20000000` | The service refuses larger screenshots. |
| `DINOV2_MAX_QUEUE` | `2` | The service refuses more waiting requests than this. |
| `DINOV2_MEM_LIMIT` | `2g` | Memory limit of the service container. |

## VLM comparison

`OLLAMA_BASE_URL` is the address of your Ollama server (default `http://host.docker.internal:11434`). Gemini is configured per project in [Project settings](Project-settings).

## Compose services

`ui`, `api`, `migration` and `postgres` always start; `dinov2` only with `--profile dinov2`. The `api` waits for `migration` to finish successfully. Docker Compose v2 is required.
