# Getting started

## Install

You need [Docker](https://docs.docker.com/get-docker/) with Compose v2.

```sh
curl -O https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/docker-compose.yml
curl -O https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/.env
sed -i.bak "s/^JWT_SECRET=.*/JWT_SECRET=$(openssl rand -hex 32)/" .env
mkdir -p imageUploads   # on Linux also: sudo chown -R 1000:1000 imageUploads
docker compose up -d
```

`JWT_SECRET` is required: the API does not start without it. All other settings are described in [Configuration](Configuration).

On Linux, macOS or WSL you can use the `vrt-install.sh` script from the repository instead; it downloads the files, sets a random `JWT_SECRET` and creates `./imageUploads`.

To reach VRT from other machines, replace `localhost` in `REACT_APP_API_URL` and `APP_FRONTEND_URL` in `.env` with a name or IP they can resolve.

## Sign in

Open http://localhost:8080 and sign in with the default user from `.env`: `DEFAULT_USER_EMAIL` and `DEFAULT_USER_PASSWORD`. Change the password in [Profile and API key](Profile-and-API-key) and replace `DEFAULT_USER_API_KEY` before anyone else can reach the server.

If you use SSO, the sign-in page shows **Login with SSO**.

The **Help** menu in the UI has a **Documentation** link to this wiki.

## Create a project

On the **Projects** page click **Add project**, enter a name and the main branch and click **Create**. See [Projects](Projects).

## Send screenshots

Your tests send screenshots through an agent, an SDK or the REST API. Each needs three values:

- the API URL (`REACT_APP_API_URL`, `http://localhost:4200` by default),
- the project id, copied from the project card with **Copy id**,
- an API key, shown on your profile page. It must belong to an Editor or an Admin: a Guest's key is refused with HTTP 403.

The **Profile** page has **Configuration examples** (a config file or environment variables) with the API URL and the selected project filled in; add your API key.

Guides per tool: [Playwright](Getting-started-with-Playwright), [Cypress](Getting-started-with-Cypress), [Selenide](Getting-started-with-Selenide), [Storybook](Storybook). Use the same major version of the client and of VRT: [How to choose the right SDK / agent version](How-to-choose-right-SDK---agent-version).

## Review the first build

The first screenshot of every screen has no baseline and gets the status New. Open the build, open a run and click **Approve** to accept it as the baseline. From then on, each new screenshot of that screen is compared with the baseline. See [Builds and runs](Builds-and-runs) and [Run dialog](Run-dialog).
