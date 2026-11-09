[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner-direct.svg)](https://stand-with-ukraine.pp.ua)

<p align="center">
  <img src="./public/logo.png" width="200px" alt="Visual Regression Tracker logo">
</p>

<h1 align="center">Visual Regression Tracker</h1>
<h3 align="center">Open-source, self-hosted visual testing. Send screenshots from any test suite, review what changed, keep baselines up to date.</h3>

<p align="center">
  <a href="#quick-start">Quick start</a> ·
  <a href="#features">Features</a> ·
  <a href="#integrations">Integrations</a> ·
  <a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki">Documentation</a> ·
  <a href="https://t.me/visual_tracker">Telegram</a>
</p>

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./public/screenshots/diff-dark.png">
  <img alt="A test run in review, Diff view: the baseline on the left, the changed price and button highlighted on the new screenshot" src="./public/screenshots/diff-light.png">
</picture>

## How it works

- **Send:** your tests take screenshots and send them to VRT through an agent, an SDK or the REST API.
- **Compare:** VRT compares each screenshot with the accepted baseline for the same name, branch, browser, OS, viewport and device.
- **Review:** unchanged screenshots pass at once. Changed ones wait in the UI: approve makes the new screenshot the baseline, reject keeps the old one.

## Features

**Review**
- Builds and test runs with filters by status, tag and noise; table or grid view.
- Side by side, diff and fade views of a screenshot against its baseline.
- Approve, reject or delete many runs at once, with a result for each.
- Undo an approval or a rejection.
- Comments on runs.

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./public/screenshots/build-dark.png">
  <img alt="A build of eleven runs: unresolved runs labelled Likely change or Likely noise, and passed runs" src="./public/screenshots/build-light.png">
</picture>

**Rendering noise**
- Flags unresolved runs as **Likely change** or **Likely noise**, so real changes are reviewed first. A hint only: it never approves anything.
- Two stages: blur on the API server, and an optional DINOv2 service for a second look.
- **Diff without noise** shows what is left of a diff once the noise is masked.

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./public/screenshots/diff-without-noise-dark.png">
  <img alt="The test run dialog in Diff without noise mode: a run labelled Likely noise, with only faint traces of the diff left" src="./public/screenshots/diff-without-noise-light.png">
</picture>

**Baselines and branches**
- Baseline history: every accepted version of a screenshot, who approved it and when.
- Feature branches compare against their own baseline or the main branch's; merge one branch's baselines into another.
- Auto-approve: baselines approved on a feature branch are approved again after the merge.
- Ignore areas for dates, ads and other parts you cannot control.

**Comparison**
- Four comparators, chosen per project:
  - [pixelmatch](https://github.com/mapbox/pixelmatch), pixel by pixel, the default;
  - [looks-same](https://github.com/gemini-testing/looks-same), perceptual;
  - [odiff](https://github.com/dmtrKovalenko/odiff), fast, with layout-shift detection;
  - VLM: pixelmatch plus a vision language model (Ollama, Gemini) that judges whether a person would notice the change ([details](https://github.com/Visual-Regression-Tracker/backend/blob/master/src/compare/libs/vlm/README.md)).
- Per-project thresholds and diff tolerance.
- Any platform: web, mobile, desktop, PDF; anything you can screenshot.

**Teams and hosting**
- Users and roles: admin, editor, guest; sign-in with a password, LDAP or SSO (OIDC).
- Statistics per project: results per build.
- Self-hosted with Docker Compose: your database, your images (local disk or S3).

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./public/screenshots/settings-dark.png">
  <img alt="Project settings: comparator, thresholds and the Post-analysis section with the blur and DINOv2 stages" src="./public/screenshots/settings-light.png">
</picture>

## Quick start

You need [Docker](https://docs.docker.com/get-docker/) with Compose v2.

```sh
curl -O https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/docker-compose.yml
curl -O https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/.env
sed -i.bak "s/^JWT_SECRET=.*/JWT_SECRET=$(openssl rand -hex 32)/" .env
mkdir -p imageUploads   # on Linux also: sudo chown -R 1000:1000 imageUploads
docker compose up -d
```

- Open http://localhost:8080 and sign in as `visual-regression-tracker@example.com` / `123456`. The API key of that user is `DEFAULT_USER_API_KEY` in `.env`. **Change both before anyone else can reach the server.**
- DINOv2 stage of the noise check: `docker compose --profile dinov2 up -d` and uncomment `DINOV2_URL` in `.env`.
- Access from other machines: replace `localhost` in `REACT_APP_API_URL` and `APP_FRONTEND_URL` with a name or IP they can resolve.
- Upgrading from 5.x: follow [Upgrade from 5.x](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki/Upgrade-from-5.x); the database moves to PostgreSQL 18.
- All settings: [Configuration](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki/Configuration).

<details>
<summary>Installation script (Linux, macOS, WSL)</summary>

```
curl https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/vrt-install.sh -o vrt-install.sh
chmod a+x vrt-install.sh
./vrt-install.sh
```

```
Usage: ./vrt-install.sh

Arguments:
    -h | --help
    -a | --frontend-url <url>   Set the Front-end url. Default: http://localhost:8080
    -r | --backend-url <url>    Set the API url. Default: http://localhost:4200
    --jwt-secret <secret>       Set the JWT secret. Default: randomly generated
```
</details>

<details>
<summary>Logs in Elasticsearch and Kibana</summary>

For admins who monitor VRT through Kibana; Elasticsearch keeps the logs and needs more memory and CPU.

1. Clone this repository and go to its folder. In `.env`, set `JWT_SECRET` (`openssl rand -hex 32`) and check `REACT_APP_API_URL`.
2. Start one of:
   - with a new Elastic stack: `docker compose -f docker-compose.yml -f docker-compose.elastic.logging.yml up`
   - with your organisation's Elasticsearch: set its hosts in `filebeat/config/filebeat.yml` and `ELASTIC_URL` in `.env`, then `docker compose -f docker-compose.yml -f docker-compose.logging.yml up`
3. If Filebeat stops with `config file ("filebeat.yml") must be owned by the user identifier (uid=0) or root`, follow the [Elastic instructions](https://www.elastic.co/guide/en/beats/libbeat/current/config-file-permissions.html) and start again.
</details>

## Integrations

| | Package |
|---|---|
| Playwright | [agent-playwright](https://www.npmjs.com/package/@visual-regression-tracker/agent-playwright) |
| Cypress | [agent-cypress](https://www.npmjs.com/package/@visual-regression-tracker/agent-cypress) |
| CodeceptJS | [agent-codeceptjs](https://github.com/Visual-Regression-Tracker/agent-codeceptjs) |
| Robot Framework | [robotframework-VRTLibrary](https://github.com/NiceProjectPoland/robotframework-VRTLibrary) (community) |
| JavaScript / TypeScript | [sdk-js](https://www.npmjs.com/package/@visual-regression-tracker/sdk-js) |
| Java | [sdk-java](https://github.com/Visual-Regression-Tracker/sdk-java) |
| Python | [sdk-python](https://github.com/Visual-Regression-Tracker/sdk-python) |
| .NET | [sdk-dotnet](https://github.com/Visual-Regression-Tracker/sdk-dotnet) |
| Anything else | REST API, Swagger at `http://localhost:4200/api` |

- Which client version fits your server: [How to choose the right SDK / agent version](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki/How-to-choose-right-SDK---agent-version).
- Examples: [JavaScript](https://github.com/Visual-Regression-Tracker/vrt-examples-js) · [Java](https://github.com/Visual-Regression-Tracker/examples-java) · [Python](https://github.com/Visual-Regression-Tracker/examples-python) · [.NET](https://github.com/Visual-Regression-Tracker/examples-dotnet)
- Guides: [Cypress](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki/Getting-started-with-Cypress) · [Playwright](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki/Getting-started-with-Playwright) · [Storybook](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki/Storybook) · [Selenide](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki/Getting-started-with-Selenide) · [Jenkins](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki/How-to-publish-VRT-result-in-jenkins) · [Images and PDF from a folder](https://github.com/Visual-Regression-Tracker/examples-java/tree/master/standalone-from-folder-maven) · [Set up on a remote machine (video)](https://www.youtube.com/watch?v=cPsHeKnqL2M)

## Glossary

- **Project**: builds and test variations of one product.
- **Build**: the test runs of one CI run.
- **Test run**: one screenshot compared with its baseline.
- **Test variation**: the history of baselines for one name + branch + OS + browser + viewport + device.
- **Baseline**: the accepted screenshot that the next run is compared with.

## Contributing

- Try it and open issues with ideas, questions and bugs.
- Tell us what you think in the [1-minute survey](https://forms.gle/DidGSodojQ4Qn4is6) or on [Telegram](https://t.me/visual_tracker).
- SDKs for more languages and agents for more frameworks are welcome.

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://www.linkedin.com/in/pavel-strunkin-310b776a/"><img src="https://avatars.githubusercontent.com/u/5182956?v=4?s=100" width="100px;" alt="Pavel Strunkin"/><br /><sub><b>Pavel Strunkin</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=pashidlos" title="Code">💻</a> <a href="#business-pashidlos" title="Business development">💼</a> <a href="#ideas-pashidlos" title="Ideas, Planning, & Feedback">🤔</a> <a href="#plugin-pashidlos" title="Plugin/utility libraries">🔌</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/dcrowe"><img src="https://avatars.githubusercontent.com/u/457807?v=4?s=100" width="100px;" alt="Daniel Crowe"/><br /><sub><b>Daniel Crowe</b></sub></a><br /><a href="#plugin-dcrowe" title="Plugin/utility libraries">🔌</a> <a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/pulls?q=is%3Apr+reviewed-by%3Adcrowe" title="Reviewed Pull Requests">👀</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/suratdas"><img src="https://avatars.githubusercontent.com/u/9042580?v=4?s=100" width="100px;" alt="Surat Das"/><br /><sub><b>Surat Das</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=suratdas" title="Code">💻</a> <a href="#plugin-suratdas" title="Plugin/utility libraries">🔌</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://alexromanov.github.io/"><img src="https://avatars.githubusercontent.com/u/4831349?v=4?s=100" width="100px;" alt="Oleksandr Romanov"/><br /><sub><b>Oleksandr Romanov</b></sub></a><br /><a href="#plugin-alexromanov" title="Plugin/utility libraries">🔌</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/TerentyevDenis"><img src="https://avatars.githubusercontent.com/u/52595906?v=4?s=100" width="100px;" alt="Terentev Denis"/><br /><sub><b>Terentev Denis</b></sub></a><br /><a href="#plugin-TerentyevDenis" title="Plugin/utility libraries">🔌</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/JustSittinHere"><img src="https://avatars.githubusercontent.com/u/394531?v=4?s=100" width="100px;" alt="JustSittinHere"/><br /><sub><b>JustSittinHere</b></sub></a><br /><a href="#plugin-JustSittinHere" title="Plugin/utility libraries">🔌</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/dekaravanhoc"><img src="https://avatars.githubusercontent.com/u/50260825?v=4?s=100" width="100px;" alt="Dekara VanHoc"/><br /><sub><b>Dekara VanHoc</b></sub></a><br /><a href="#plugin-dekaravanhoc" title="Plugin/utility libraries">🔌</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="http://frabbit.ru"><img src="https://avatars.githubusercontent.com/u/9402252?v=4?s=100" width="100px;" alt="maddocnc"/><br /><sub><b>maddocnc</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=maddocnc" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/AaronChelvan"><img src="https://avatars.githubusercontent.com/u/16505870?v=4?s=100" width="100px;" alt="Aaron Chelvan"/><br /><sub><b>Aaron Chelvan</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=AaronChelvan" title="Code">💻</a> <a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=AaronChelvan" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/marcm-qa"><img src="https://avatars.githubusercontent.com/u/80327313?v=4?s=100" width="100px;" alt="marcm-qa"/><br /><sub><b>marcm-qa</b></sub></a><br /><a href="#plugin-marcm-qa" title="Plugin/utility libraries">🔌</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/Eduard-iCH"><img src="https://avatars.githubusercontent.com/u/33355363?v=4?s=100" width="100px;" alt="Eduard-iCH"/><br /><sub><b>Eduard-iCH</b></sub></a><br /><a href="#plugin-Eduard-iCH" title="Plugin/utility libraries">🔌</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://dev.flauschig.ch"><img src="https://avatars.githubusercontent.com/u/393641?v=4?s=100" width="100px;" alt="Roman"/><br /><sub><b>Roman</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=Roemer" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://dimitriharding.com"><img src="https://avatars.githubusercontent.com/u/12203794?v=4?s=100" width="100px;" alt="Dimitri Harding"/><br /><sub><b>Dimitri Harding</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=dimitriharding" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/vkostromin94"><img src="https://avatars.githubusercontent.com/u/80275969?v=4?s=100" width="100px;" alt="vkostromin94"/><br /><sub><b>vkostromin94</b></sub></a><br /><a href="#plugin-vkostromin94" title="Plugin/utility libraries">🔌</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/bmbferreira"><img src="https://avatars.githubusercontent.com/u/626180?v=4?s=100" width="100px;" alt="Bruno Ferreira"/><br /><sub><b>Bruno Ferreira</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=bmbferreira" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/nicerloop"><img src="https://avatars.githubusercontent.com/u/44115467?v=4?s=100" width="100px;" alt="Loïc PÉRON"/><br /><sub><b>Loïc PÉRON</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=nicerloop" title="Code">💻</a> <a href="#plugin-nicerloop" title="Plugin/utility libraries">🔌</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://htts://vk.com/wsbaser"><img src="https://avatars.githubusercontent.com/u/7660756?v=4?s=100" width="100px;" alt="Alexey Volkov"/><br /><sub><b>Alexey Volkov</b></sub></a><br /><a href="#plugin-wsbaser" title="Plugin/utility libraries">🔌</a> <a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=wsbaser" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://legori.ru"><img src="https://avatars.githubusercontent.com/u/2931416?v=4?s=100" width="100px;" alt="Egor Lipskiy"/><br /><sub><b>Egor Lipskiy</b></sub></a><br /><a href="#plugin-elipskiy" title="Plugin/utility libraries">🔌</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/nitschSB"><img src="https://avatars.githubusercontent.com/u/39341455?v=4?s=100" width="100px;" alt="nitschSB"/><br /><sub><b>nitschSB</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=nitschSB" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/polyvisual"><img src="https://avatars.githubusercontent.com/u/513415?v=4?s=100" width="100px;" alt="polyvisual"/><br /><sub><b>polyvisual</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=polyvisual" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://paazmaya.fi"><img src="https://avatars.githubusercontent.com/u/369881?v=4?s=100" width="100px;" alt="Juga Paazmaya"/><br /><sub><b>Juga Paazmaya</b></sub></a><br /><a href="#plugin-paazmaya" title="Plugin/utility libraries">🔌</a> <a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=paazmaya" title="Code">💻</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/s-weigand"><img src="https://avatars.githubusercontent.com/u/9513634?v=4?s=100" width="100px;" alt="Sebastian Weigand"/><br /><sub><b>Sebastian Weigand</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=s-weigand" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/oleg-rd"><img src="https://avatars.githubusercontent.com/u/73664101?v=4?s=100" width="100px;" alt="Oleg Ridchenko"/><br /><sub><b>Oleg Ridchenko</b></sub></a><br /><a href="#plugin-oleg-rd" title="Plugin/utility libraries">🔌</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/groinder"><img src="https://avatars.githubusercontent.com/u/16709010?v=4?s=100" width="100px;" alt="Krzysztof Przybylski"/><br /><sub><b>Krzysztof Przybylski</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=groinder" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/adriannieto"><img src="https://avatars.githubusercontent.com/u/7558172?v=4?s=100" width="100px;" alt="Adrian N."/><br /><sub><b>Adrian N.</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=adriannieto" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/nGervasyuk"><img src="https://avatars.githubusercontent.com/u/20280571?v=4?s=100" width="100px;" alt="Nikolay Gervasyuk"/><br /><sub><b>Nikolay Gervasyuk</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=nGervasyuk" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://adabru.de"><img src="https://avatars.githubusercontent.com/u/6108978?v=4?s=100" width="100px;" alt="Adam Brunnmeier"/><br /><sub><b>Adam Brunnmeier</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=adabru" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/okstryzhak"><img src="https://avatars.githubusercontent.com/u/117097798?v=4?s=100" width="100px;" alt="Oksana Stryzhak"/><br /><sub><b>Oksana Stryzhak</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=okstryzhak" title="Code">💻</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://bevyl.ai"><img src="https://avatars.githubusercontent.com/u/667653?v=4?s=100" width="100px;" alt="Noah"/><br /><sub><b>Noah</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=Octember" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/mokhtardziri"><img src="https://avatars.githubusercontent.com/u/267088220?v=4?s=100" width="100px;" alt="mokhtardziri"/><br /><sub><b>mokhtardziri</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=mokhtardziri" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/Roman1137"><img src="https://avatars.githubusercontent.com/u/32763749?v=4?s=100" width="100px;" alt="Roman1137"/><br /><sub><b>Roman1137</b></sub></a><br /><a href="#plugin-Roman1137" title="Plugin/utility libraries">🔌</a> <a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=Roman1137" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/tchiaspko"><img src="https://avatars.githubusercontent.com/u/49214278?v=4?s=100" width="100px;" alt="Tony Chia"/><br /><sub><b>Tony Chia</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=tchiaspko" title="Code">💻</a> <a href="#example-tchiaspko" title="Examples">💡</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/dortizesquivel"><img src="https://avatars.githubusercontent.com/u/1325218?v=4?s=100" width="100px;" alt="dortizesquivel"/><br /><sub><b>dortizesquivel</b></sub></a><br /><a href="#infra-dortizesquivel" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://www.linkedin.com/in/shankysharma/"><img src="https://avatars.githubusercontent.com/u/11002110?v=4?s=100" width="100px;" alt="Shanky Sharma"/><br /><sub><b>Shanky Sharma</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=shankybnl" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/rschmidt-webit"><img src="https://avatars.githubusercontent.com/u/128089901?v=4?s=100" width="100px;" alt="rschmidt-webit"/><br /><sub><b>rschmidt-webit</b></sub></a><br /><a href="#example-rschmidt-webit" title="Examples">💡</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/stp4k"><img src="https://avatars.githubusercontent.com/u/29662401?v=4?s=100" width="100px;" alt="Stepan Churakov"/><br /><sub><b>Stepan Churakov</b></sub></a><br /><a href="#example-stp4k" title="Examples">💡</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->
This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
