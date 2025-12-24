[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner-direct.svg)](https://stand-with-ukraine.pp.ua)

<p align="center">
  <img src="./public/logo.png"/ width='200px' alt="Visual Regression Tracker logo">
</p>

<h1 align="center"> Visual Regression Tracker </h1>
<h3 align="center"> Open source, self hosted solution for visual testing and managing results of visual testing. </h3>

## Hello 
* Take [1-minute survey](https://forms.gle/DidGSodojQ4Qn4is6) to help us priorities tasks better ❤️
* [Twitter](https://twitter.com/VisualReTracker)
* [Telegram group](https://t.me/visual_tracker)

## How it works
Service receives images, performs pixel by pixel comparison with it’s previously accepted baseline and provides immediate results in order to catch unexpected changes. 

![Demo](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/blob/master/public/demo.gif)

## Features
* **Automation framework independent** - no need to stick with specific automation tool, integrate with existing one
* **Platform independent** - web, mobile, desktop etc. as long as you could make a screenshot
* **Baseline history** - track how baseline image changed since the beginning
* **Ignore regions** - improve stability by ignoring not important or not controllable parts of image
* **Language support** - JS, Java, Python, .Net or any other via REST API (need more?)
* **Easy setup** - everything is inside Docker images
* **Self-hosted** - keep your data save inside your intranet
* **Can compare PDF too** - use standalone jar to compare pdf and images from a folder

## Image Comparison Providers

Visual Regression Tracker supports multiple image comparison algorithms, each with different strengths and use cases:

### Available Providers

* **Pixelmatch** - Fast pixel-by-pixel comparison algorithm. Default comparison method. Best for detecting exact pixel differences.
  * Library: [pixelmatch](https://github.com/mapbox/pixelmatch)
  
* **Looks-Same** - Perceptual image comparison that considers human visual perception. Good for ignoring minor rendering differences.
  * Library: [looks-same](https://github.com/gemini-testing/looks-same)
  
* **Odiff** - Advanced diff tool with layout detection and anti-aliasing support. Useful for detecting layout shifts.
  * Library: [odiff-bin](https://github.com/dmtrKovalenko/odiff)
  
* **VLM (Vision Language Model)** - Hybrid comparison combining pixelmatch with AI-powered human-noticeability analysis using Vision Language Models. Analyzes if differences are actually noticeable to humans.
  * Documentation: [VLM README](https://github.com/Visual-Regression-Tracker/backend/blob/master/src/compare/libs/vlm/README.md)

You can configure which comparison provider to use per project in the project settings.

## Glossary
* TestVariation - historical record of Baselines by Name + Branch + OS + Browser + Viewport + Device, 
* Baseline - validated and accepted image, latest will be used as expected result in TestRun
* TestRun - result of comparing image against Baseline
* Build - list of TestRuns
* Project - list of Builds and TestVariations

## Set up

Use any of the below ways to setup the server. [Docker](https://docs.docker.com/get-docker/) has to be installed on the machine.

<details>
<summary>Quick Setup</summary>

### Linux, macOS, WSL

1. Download the installation script

```
curl https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/vrt-install.sh -o vrt-install.sh
chmod a+x vrt-install.sh
```

2. Run the installation script

`./vrt-install.sh`

#### Command line arguments

```
Installs the Visual Regression Tracker

Usage: ./vrt-install.sh

Arguments:
    -h | --help
    -a | --frontend-url <url>   Set the Front-end url. Default: http://localhost:8080
    -r | --backend-url <url>    Set the API url. Default: http://localhost:4200
    --jwt-secret <secret>       Set the JWT secret. Default: randomly generated
```
</details>

<details>
<summary>Manual Setup</summary>

1. Copy [docker-compose.yml](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/blob/master/docker-compose.yml)  

`$ curl https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/docker-compose.yml -o docker-compose.yml`

2. Copy [.env](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/blob/master/.env) 

`$ curl https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/.env -o .env`

3. In .env file, ensure that the REACT_APP_API_URL has the right address. If it will be accessed from other machines, change localhost with IP or other resolvable name. Ensure the ports being used are free to use.

4. Start service

`$ docker-compose up`


Wait until you see your creds printed.

New users and projects could be created via frontend app by default on http://localhost:8080

![Success setup](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/blob/master/public/docker_setup_creds.png)
</details>

<details>
<summary>Run VRT with logging enabled in Elasticsearch</summary>

This is for the users who want to monitor VRT logs via Kibana. It is expected to have basic knowledge of Elastic stack (especially Kibana) for the admin so that the logs can be managed and dashboards created in Kibana. 
Since logging will be retained by Elasticsearch, it will consume a little more memory and CPU. If you see error in the console, please consult Elasticsearch documentation.

_**It is recommended to run the program as root user which will ensure permission and ownership related issues will not have to be dealt with.**_

1. Clone or download this repository.  
2. Move to the downloaded/cloned repository. In .env file, ensure that the REACT_APP_API_URL has the right address. If it will be accessed from other machines, change localhost with IP or other resolvable name. Ensure the ports being used are free to use.
3. Follow either of below sub steps.  
   - If your organization does not have Elasticsearch server running or if you want to start Elastic stack on your own, start service by giving below command.
  
     `$ docker-compose -f docker-compose.yml -f docker-compose.elastic.logging.yml up`
   - If you want to re-use the already running Elasticsearch server in your organization, go to `filebeat/config/filebeat.yml` and edit hosts to point to the Elasticsearch server. Also, point ELASTIC_URL to this server in .env file. Start service by giving below command.

     `$ docker-compose -f docker-compose.yml -f docker-compose.logging.yml up`

4. If you are not using root user, in some OS, you may see an error `Exiting: error loading config file: config file ("filebeat.yml") must be owned by the user identifier (uid=0) or root`. In that case, press Ctrl+C, and follow [Elasticsearch instructions](https://www.elastic.co/guide/en/beats/libbeat/current/config-file-permissions.html). Once done, start the service again.
</details>

## Integration
Use implemented libraries to integrate with existing automated suites by adding assertions based on image comparison.
We provide native integration with automation libraries, core SDK and Rest API interfaces that allow the system to be used with any existing programming language.

### Agents
* [Playwright](https://www.npmjs.com/package/@visual-regression-tracker/agent-playwright)
* [Cypress](https://www.npmjs.com/package/@visual-regression-tracker/agent-cypress)
* [CodeceptJS](https://github.com/Visual-Regression-Tracker/agent-codeceptjs)
* [Robot Framework](https://github.com/NiceProjectPoland/robotframework-VRTLibrary)

### Core SDK
Basic wrapper over API to be used for integration with existing tools
* [JavaScript](https://www.npmjs.com/package/@visual-regression-tracker/sdk-js)
* [Java](https://github.com/Visual-Regression-Tracker/sdk-java)
* [Python](https://github.com/Visual-Regression-Tracker/sdk-python)
* [Dotnet](https://github.com/Visual-Regression-Tracker/sdk-dotnet)

## Getting started guide

### Videos

* [How to set up on Remote machine via ssh](https://www.youtube.com/watch?v=cPsHeKnqL2M&feature=emb_logo)

### Wiki

* [Cypress](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki/Getting-started-with-Cypress)
* [Playwright](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki/Getting-started-with-Playwright)
* [Storybook](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki/Storybook)
* [Selenide (Java)](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki/Getting-started-with-Selenide)
* [Jenkins VRT result publishing example (with JAVA SDK)](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki/How-to-publish-VRT-result-in-jenkins)
* [Compare image and pdf files as CLI](https://github.com/Visual-Regression-Tracker/examples-java/tree/master/standalone-from-folder-maven)

## Integration examples
Here you could find examples 
* [JavaScript](https://github.com/Visual-Regression-Tracker/vrt-examples-js)
* [Java](https://github.com/Visual-Regression-Tracker/examples-java)
* [Python](https://github.com/Visual-Regression-Tracker/examples-python)
* [Dotnet](https://github.com/Visual-Regression-Tracker/examples-dotnet)

## Contribution
1. Try it, raise tickets with ideas, questions, bugs and share feedback :)
1. More language support for SDK
1. More integration with specific testing frameworks (agents)

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
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->
This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
