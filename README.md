# Visual Regression Tracker
Service for tracking visual changes in your application.

![demo](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/blob/master/public/demo.gif)

## Features
* Baseline history - track how baseline image changed since the beginning
* Ignore regions - improve stability by ignoring not important or not controllable parts of image
* Web, mobile, desktop - any type of application is supported as long as you could make a screenshot
* Language support: JS, Java or any other via REST API (need more?)
* Easy setup - everything is inside Docker images
* Self-hosted - keep your data save inside your intranet

## Glossary
* TestVariation - unique identifier for Baseline, consists of Name + OS + Browser + Viewport
* Baseline - validated and accepted image, latest baseline will be used as expected result in TestRun
* TestRun - result of comparing image against Baseline
* Build - list of TestRuns
* Project - list of Builds and TestVariations

## Set up
1. Install [Docker](https://docs.docker.com/get-docker/)
1. Copy [docker-compose.yml](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/blob/master/docker-compose.yml) and [.env](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/blob/master/.env) in one folder
1. Create folder for images `imageUploads`
1. `$ docker-compose up`
1. open http://localhost:8080
1. Login with default user: `visual-regression-tracker@example.com/123456` and copy it's `apiKey`
1. Create a new project and copy it's `projectId`
1. See blow `Integration examples` how to send data to the service

## Integration examples
Here you could find examples that shows how to use `Core SDK` together with popular tools 
* [JavaScript](https://github.com/Visual-Regression-Tracker/vrt-examples-js) - Playwright
* [Java](https://github.com/Visual-Regression-Tracker/examples-java) - Selenium WebDriver

## Core SDK
Basic wrapper over API to be used for integration with existing tools
* [JavaScript](https://www.npmjs.com/package/@visual-regression-tracker/sdk-js)
* [Java](https://github.com/Visual-Regression-Tracker/sdk-java)

## Contribution
1. Try it, rise tickets with ideas, questions, bugs and share feedback :)
1. Logo image
1. More language support for Core SDK
1. Seamles integration with specific testing frameworks 
