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

## Glossary
* TestVariation - historical record of Baselines by Name + Branch + OS + Browser + Viewport + Device, 
* Baseline - validated and accepted image, latest will be used as expected result in TestRun
* TestRun - result of comparing image against Baseline
* Build - list of TestRuns
* Project - list of Builds and TestVariations

## Set up

### Linux, macOS, WSL

1. Install [Docker](https://docs.docker.com/get-docker/)
2. Download the installation script

```
curl https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/vrt-install.sh -o vrt-install.sh
chmod a+x vrt-install.sh
```

3. Run the installation script

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

### By Hand

1. Install [Docker](https://docs.docker.com/get-docker/)
2. Copy [docker-compose.yml](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/blob/master/docker-compose.yml)  

`$ curl https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/docker-compose.yml -o docker-compose.yml`

3. Copy [.env](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/blob/master/.env) 

`$ curl https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/.env -o .env`

4. Start service

`$ docker-compose up`

Wait untill you see your creds printed.

New users and projects could be created via frontend app by default on http://localhost:8080

![Success setup](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/blob/master/public/docker_setup_creds.png)

## Integration
Use implemented libraries to integrate with existing automated suites by adding assertions based on image comparison.
We provide native integration with automation libraries, core SDK and Rest API interfaces that allow the system to be used with any existing programming language.

### Agents
* [Playwright](https://www.npmjs.com/package/@visual-regression-tracker/agent-playwright)
* [Cypress](https://www.npmjs.com/package/@visual-regression-tracker/agent-cypress)
* [CodeceptJS](https://github.com/Visual-Regression-Tracker/agent-codeceptjs)

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
  <tr>
    <td align="center"><a href="https://www.linkedin.com/in/pavel-strunkin-310b776a/"><img src="https://avatars.githubusercontent.com/u/5182956?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Pavel Strunkin</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=pashidlos" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/dcrowe"><img src="https://avatars.githubusercontent.com/u/457807?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Daniel Crowe</b></sub></a><br /><a href="#plugin-dcrowe" title="Plugin/utility libraries">🔌</a></td>
    <td align="center"><a href="https://github.com/suratdas"><img src="https://avatars.githubusercontent.com/u/9042580?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Surat Das</b></sub></a><br /><a href="https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/commits?author=suratdas" title="Code">💻</a> <a href="#plugin-suratdas" title="Plugin/utility libraries">🔌</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->
This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
