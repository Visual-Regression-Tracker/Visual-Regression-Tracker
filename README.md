# Visual Regression Tracker
Open source, self hosted solution for visual testing and managing results of visual testing. 

## How it works
Service receives images, performs pixel by pixel comparison with it’s previously accepted baseline and provides immediate results in order to catch unexpected changes. 

## Getting started guide
* [Playwright](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki/Getting-started-with-Playwright)
* [Storybook](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki/Storybook)
* [Selenide (Java)](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/wiki/Getting-started-with-Selenide)

## Features
* **Automation framework independent** - no need to stick with specific automation tool, integrate with existing one
* **Platform independent** - web, mobile, desktop etc. as long as you could make a screenshot
* **Baseline history** - track how baseline image changed since the beginning
* **Ignore regions** - improve stability by ignoring not important or not controllable parts of image
* **Language support** - JS, Java or any other via REST API (need more?)
* **Easy setup** - everything is inside Docker images
* **Self-hosted** - keep your data save inside your intranet

## Glossary
* TestVariation - unique identifier for Baseline, consists of Name + OS + Browser + Viewport
* Baseline - validated and accepted image, latest baseline will be used as expected result in TestRun
* TestRun - result of comparing image against Baseline
* Build - list of TestRuns
* Project - list of Builds and TestVariations

## Set up
1. Install [Docker](https://docs.docker.com/get-docker/)
2. Copy [docker-compose.yml](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/blob/master/docker-compose.yml)  

`$ curl https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/docker-compose.yml -o docker-compose.yml`

3. Copy [.env](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/blob/master/.env) 

`$ curl https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/.env -o .env`

4. Create folder for images `imageUploads`

`$ mkdir imageUploads`

5. Start service

`$ docker-compose up`

Wait untill you see your creds printed.

New users and projects could be created via frontend app by default on http://localhost:8080

![Success setup](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/blob/master/public/docker_setup_creds.png)

### Integration
Use implemented libraries to integrate with existing automated suites by adding assertions based on image comparison.
We provide native integration with automation libraries, core SDK and Rest API interfaces that allow the system to be used with any existing programming language.

## Agents
* [Playwright](https://www.npmjs.com/package/@visual-regression-tracker/agent-playwright)
* [Cypress](https://www.npmjs.com/package/@visual-regression-tracker/agent-cypress)

## Core SDK
Basic wrapper over API to be used for integration with existing tools
* [JavaScript](https://www.npmjs.com/package/@visual-regression-tracker/sdk-js)
* [Java](https://github.com/Visual-Regression-Tracker/sdk-java)

## Integration examples
Here you could find examples 
* [JavaScript](https://github.com/Visual-Regression-Tracker/vrt-examples-js) - Playwright, core SDK
* [Java](https://github.com/Visual-Regression-Tracker/examples-java) - Selenium WebDriver

## Contribution
1. Try it, raise tickets with ideas, questions, bugs and share feedback :)
1. Logo image
1. More language support for Core SDK
1. Seamless integration with specific testing frameworks 

## Community
* [Telegram group](https://t.me/visual_tracker)
