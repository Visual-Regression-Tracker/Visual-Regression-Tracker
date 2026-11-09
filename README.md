[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner-direct.svg)](https://stand-with-ukraine.pp.ua)

<p align="center">
  <img src="./public/logo.png" width="200px" alt="Visual Regression Tracker logo">
</p>

<h1 align="center">Visual Regression Tracker</h1>
<h3 align="center">Open-source, self-hosted visual testing.</h3>

<p align="center">
  <a href="#quick-start">Quick start</a> ·
  <a href="#features">Features</a> ·
  <a href="#integrations">Integrations</a> ·
  <a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki">Documentation</a> ·
  <a href="https://t.me/visual_tracker">Telegram</a>
</p>

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./public/screenshots/diff-dark.png">
  <img alt="A test run in review: the baseline and the new screenshot with the changes highlighted" src="./public/screenshots/diff-light.png">
</picture>

## How it works

- Tests send screenshots through an agent, an SDK or the REST API.
- Each screenshot is compared with its baseline (same name, branch, browser, OS, viewport, device).
- Unchanged ones pass; changed ones wait for review: approve or reject.

## Features

- Any test framework, any platform: web, mobile, desktop, PDF.
- Comparators per project: pixelmatch, looks-same, odiff, VLM (Ollama, Gemini).
- Review: side by side, diff, fade; filters; bulk approve, reject, delete; undo; comments.
- Rendering-noise hint: Likely change / Likely noise, Diff without noise; blur plus optional DINOv2.
- Baseline history per screenshot, with who approved and when.
- Branches: own baselines, merge between branches, auto-approve after merge.
- Ignore areas.
- Statistics per project.
- Users and roles; password, LDAP or SSO (OIDC) sign-in.
- Self-hosted with Docker Compose; images on local disk or S3.

## Quick start

Needs [Docker](https://docs.docker.com/get-docker/) with Compose v2.

```sh
curl -O https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/docker-compose.yml
curl -O https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/.env
sed -i.bak "s/^JWT_SECRET=.*/JWT_SECRET=$(openssl rand -hex 32)/" .env
mkdir -p imageUploads   # on Linux also: sudo chown -R 1000:1000 imageUploads
docker compose up -d
```

- UI: http://localhost:8080, user `visual-regression-tracker@example.com` / `123456`, API key `DEFAULT_USER_API_KEY` in `.env`. Change both.
- Or run [`vrt-install.sh`](vrt-install.sh) (Linux, macOS, WSL).
- [Configuration](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki/Configuration) · [Upgrade from 5.x](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki/Upgrade-from-5.x) · [Logs in Elasticsearch](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki/Logs-in-Elasticsearch)

## Integrations

- Agents: [Playwright](https://www.npmjs.com/package/@visual-regression-tracker/agent-playwright) · [Cypress](https://www.npmjs.com/package/@visual-regression-tracker/agent-cypress) · [CodeceptJS](https://github.com/Visual-Regression-Tracker/agent-codeceptjs) · [Robot Framework](https://github.com/NiceProjectPoland/robotframework-VRTLibrary) (community)
- SDKs: [JavaScript](https://www.npmjs.com/package/@visual-regression-tracker/sdk-js) · [Java](https://github.com/Visual-Regression-Tracker/sdk-java) · [Python](https://github.com/Visual-Regression-Tracker/sdk-python) · [.NET](https://github.com/Visual-Regression-Tracker/sdk-dotnet)
- REST API: Swagger at `http://localhost:4200/api`
- Examples: [JavaScript](https://github.com/Visual-Regression-Tracker/vrt-examples-js) · [Java](https://github.com/Visual-Regression-Tracker/examples-java) · [Python](https://github.com/Visual-Regression-Tracker/examples-python) · [.NET](https://github.com/Visual-Regression-Tracker/examples-dotnet)
- [Which client version to use](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki/How-to-choose-right-SDK---agent-version)

## Glossary

- **Project**: builds and test variations of one product.
- **Build**: the test runs of one CI run.
- **Test run**: one screenshot compared with its baseline.
- **Test variation**: baseline history for one name + branch + OS + browser + viewport + device.
- **Baseline**: the accepted screenshot.

## Contributing

Issues, ideas and new SDKs or agents are welcome. Feedback: [survey](https://forms.gle/DidGSodojQ4Qn4is6) · [Telegram](https://t.me/visual_tracker).

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
