# Getting started

Install VRT, sign in and send your first screenshot.

## Install

You need [Docker](https://docs.docker.com/get-docker/) with Compose v2.

1. Download the files and set a secret:

   ```sh
   curl -O https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/docker-compose.yml
   curl -O https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/.env
   sed -i.bak "s/^JWT_SECRET=.*/JWT_SECRET=$(openssl rand -hex 32)/" .env
   mkdir -p imageUploads   # on Linux also: sudo chown -R 1000:1000 imageUploads
   ```

2. Start VRT: `docker compose up -d`.

Notes:

- `JWT_SECRET` is required. The API does not start without it.
- On Linux, macOS or WSL, `vrt-install.sh` from the repository does step 1 for you.
- To reach VRT from other machines, change `REACT_APP_API_URL` and `APP_FRONTEND_URL` in `.env`.
- All settings: [Configuration](Configuration).

## Sign in

1. Open http://localhost:8080.
2. Sign in with `DEFAULT_USER_EMAIL` and `DEFAULT_USER_PASSWORD` from `.env`.
3. Change the password in [Profile and API key](Profile-and-API-key).
4. Replace `DEFAULT_USER_API_KEY` before others can reach the server.

With SSO, use **Login with SSO**. The **Help** menu links to this wiki.

## Create a project

1. On **Projects**, click **Add project**.
2. Enter a name and the main branch.
3. Click **Create**. See [Projects](Projects).

## Send screenshots

Your tests send screenshots through an agent, an SDK or the REST API. You need three values:

- **API URL**: `http://localhost:4200` by default.
- **Project id**: in the address of the project page.
- **API key**: on your profile page. It must belong to an Editor or Admin.

The **Profile** page shows ready-made **Configuration examples**. Add your API key.

Guides:

- [Playwright](Getting-started-with-Playwright)
- [Cypress](Getting-started-with-Cypress)
- [Selenide](Getting-started-with-Selenide)
- [Storybook](Storybook)

Use the same major version of client and server.
See [SDK / agent version](How-to-choose-right-SDK---agent-version).

## Review the first build

1. Run your tests. Each first screenshot gets the status **New**.
2. Open the build and click a run.
3. Click **Approve**. The screenshot becomes the baseline.

Next runs are compared with it. See [Builds and runs](Builds-and-runs) and [Run dialog](Run-dialog).
