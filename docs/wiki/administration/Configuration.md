# Configuration

VRT reads the `.env` file next to `docker-compose.yml`.

1. Edit `.env`.
2. Run `docker compose up -d`.

Commented-out settings use the default shown.

## Required

| Variable | Meaning |
|---|---|
| `JWT_SECRET` | Signs login tokens. No start without it. Use `openssl rand -hex 32`. |

The old sample value `jwtPrivateKey` is refused. Changing the secret signs everyone out once.

## Addresses and ports

| Variable | Default | Meaning |
|---|---|---|
| `REACT_APP_API_URL` | `http://localhost:4200` | API URL as the browser sees it. |
| `APP_FRONTEND_URL` | `http://localhost:8080` | UI URL. |
| `PORT` | `8080` | Host port of the UI. |
| `APP_PORT` | `4200` | Host port of the API. |

## Versions

- `VRT_UI_VERSION`, `VRT_API_VERSION`, `VRT_MIGRATION_VERSION`: image tags. Use the versions of one VRT release; they can differ (VRT 6.1.0 is UI 6.1.0 with API and migration 6.0.0).
- `VRT_DINOV2_VERSION`: tag of the optional DINOv2 service.

## Database

- `POSTGRES_PORT`, `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB` configure the bundled PostgreSQL 18.
- `docker-compose.yml` builds `DATABASE_URL` from them. A `DATABASE_URL` in `.env` is ignored.

To use your own database:

1. Edit `DATABASE_URL` for `api` and `migration` in `docker-compose.yml`.
2. Add `?sslmode=require` for TLS. VRT 6.0 connects without TLS otherwise.

## First admin

`DEFAULT_USER_EMAIL`, `DEFAULT_USER_PASSWORD` and `DEFAULT_USER_API_KEY` create the first admin.
They only apply to a new database. Change the samples.

## Sessions and limits

| Variable | Default | Meaning |
|---|---|---|
| `JWT_LIFE_TIME` | `1d` | Login duration. |
| `BODY_PARSER_JSON_LIMIT` | `5mb` | Largest JSON body. Bigger gets HTTP 413. |
| `MULTIPART_FILE_SIZE_LIMIT` | `104857600` | Largest multipart upload, in bytes. |
| `MAX_IMAGE_PIXELS` | `100000000` | Larger screenshots are refused. |
| `REGISTRATION_ENABLED` | `true` | `false` hides sign-up. |
| `LOG_LEVEL` | `log,error,warn,fatal` | Nest log levels. Add `debug` or `verbose`. |
| `DIFF_WORKER_MAX_HEAP_MB` | `512` | Memory per comparison worker. Raise for large screenshots. |

The comparison pool size is fixed: CPUs minus one (1 to 8), with up to 256 jobs waiting.
A full queue answers `503` with `Retry-After: 5`.

## Image storage

- Default: `./imageUploads`.
- Amazon S3: set `STATIC_SERVICE=s3`, `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_REGION`, `AWS_S3_BUCKET_NAME`.

The API runs as user id 1000. On Linux run `sudo chown -R 1000:1000 ./imageUploads ./ssl`.

## HTTPS

1. Mount a key and a certificate. The sample `docker-compose.yml` has the mounts commented out.
2. Set `HTTPS_KEY_PATH` and `HTTPS_CERT_PATH`. Defaults: `./secrets/ssl.key`, `./secrets/ssl.cert`.

The API uses HTTPS only when both files exist.

## Sign-in

**LDAP:** `LDAP_ENABLED=true` and:

- `LDAP_URL`, `LDAP_BIND_USER`, `LDAP_BIND_PASSWORD`
- `LDAP_SEARCH_DN`, `LDAP_USERS_SEARCH_FILTER`
- `LDAP_ATTRIBUTE_MAIL`, `LDAP_ATTRIBUTE_FIRST_NAME`, `LDAP_ATTRIBUTE_LAST_NAME`
- `LDAP_TLS_NO_VERIFY`

**SSO (OpenID Connect):** `OIDC_ENABLED=true` and:

- `OIDC_ISSUER_URL`, `OIDC_CLIENT_ID`, `OIDC_CLIENT_SECRET`
- `OIDC_REDIRECT_URI`: default `http://localhost:4200/users/oidc/callback`. Register it at your provider.

SSO beats LDAP and turns off password login and sign-up. Optional settings:

| Variable | Default |
|---|---|
| `OIDC_SCOPES` | `openid profile email` |
| `OIDC_ATTRIBUTE_MAIL`, `OIDC_ATTRIBUTE_FIRST_NAME`, `OIDC_ATTRIBUTE_LAST_NAME` | provider default |
| `OIDC_ROLE_CLAIM` | `groups` |
| `OIDC_ADMIN_VALUES` | `vrt-admin,admin` |
| `OIDC_DEFAULT_ROLE` | `editor` |
| `OIDC_REQUIRE_VERIFIED_EMAIL` | `true` |
| `OIDC_TLS_NO_VERIFY` | `false` |

The role is updated from the provider at every login.
`REACT_APP_OIDC_AUTO_REDIRECT=true` skips the **Login with SSO** button.

## Live updates

Live updates need a signed-in UI 6.0. Clients get only events of what they view.

| Variable | Default | Meaning |
|---|---|---|
| `REDIS_URL` | empty | Needed with more than one API instance. Add your own Redis. |

## Rendering-noise check

The blur stage needs nothing. For the DINOv2 stage:

1. Run `docker compose --profile dinov2 up -d`.
2. Uncomment `DINOV2_URL=http://dinov2:8000` in `.env`.

| Variable | Default | Meaning |
|---|---|---|
| `DINOV2_URL` | empty | DINOv2 address. Empty means blur only. |
| `DINOV2_TIMEOUT_MS` | `60000` | How long the API waits. |
| `DINOV2_MAX_PIXELS` | `20000000` | Larger screenshots are refused. |
| `DINOV2_MAX_QUEUE` | `2` | Waiting requests allowed. |
| `DINOV2_MEM_LIMIT` | `2g` | Container memory limit. |

See [Noise hint](Noise-hint).

## VLM comparison

- `OLLAMA_BASE_URL`: your Ollama server. Default `http://host.docker.internal:11434`.
- Gemini is set per project in [Project settings](Project-settings).

## Compose services

- Always: `ui`, `api`, `migration`, `postgres`.
- With `--profile dinov2`: `dinov2`.
- `api` waits for `migration` to finish.
