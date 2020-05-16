# Visual Regression Tracker
Service for tracking visual changes in your application.

## Set up
1. Install [Docker](https://docs.docker.com/get-docker/)
2. Copy [docker-compose.yml](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/blob/master/docker-compose.yml) and [.env](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/blob/master/.env) in one folder
3. `$ docker-compose up`
4. open http://localhost:8080
5. Login with default user: `visual-regression-tracker@example.com/123456` and copy it's `apiKey`
6. Create a new project and copy it's `projectId`
7. See blow `Integration examples` how to send data to the service

## Integration examples
Here you could find examples that shows how to use `Core SDK` together with popular tools 
* [JavaScript](https://github.com/Visual-Regression-Tracker/vrt-examples-js) - Playwright
* [Java](https://github.com/Visual-Regression-Tracker/examples-java) - Selenium WebDriver

## Core SDK
Basic wrapper over API to be used for integration with existing tools
* [JavaScript](https://www.npmjs.com/package/@visual-regression-tracker/sdk-js)
* [Java](https://github.com/Visual-Regression-Tracker/sdk-java)
