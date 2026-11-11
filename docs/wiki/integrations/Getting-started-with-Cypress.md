# Getting started with Cypress

Use [Cypress](https://www.cypress.io/) with [agent-cypress](https://www.npmjs.com/package/@visual-regression-tracker/agent-cypress).

## Prerequisites

VRT is running: [Getting started](Getting-started).

## Clone the example

```sh
git clone https://github.com/Visual-Regression-Tracker/examples-js.git
cd examples-js/agent-cypress
npm install
```

## Configure

Set the environment in `cypress.json`:

```json
{
  "env": {
    "visualRegressionTracker": {
      "apiUrl": "http://localhost:4200",
      "project": "Default project",
      "apiKey": "<your API key>",
      "branchName": "master"
    }
  }
}
```

The example already has the plugin. For your own project, follow the
[installation guide](https://www.npmjs.com/package/@visual-regression-tracker/agent-cypress#installation).

## Add an assertion

Whole page:

```js
cy.track('Image name')
```

One element:

```js
cy.get('#navbar').track('Image name')
```

With options, to tell apart the same image on different setups:

```js
cy.track("With additional options", {
  os: "MacOS",
  device: "Cloud agent",
  diffTollerancePercent: 1,
})
```

Viewport comes from `Cypress.config()`, browser from `Cypress.browser.name`.

## Run

1. Run `npx cypress open` and pick a suite.
2. The test fails with a link: there is no baseline yet.

![init run](https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/public/cypress_tutorial/init_run.png)

## Approve baselines

Open the link and approve the image.

![success run](https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/public/cypress_tutorial/success_run.png)

## Diff found

A difference above the tolerance is highlighted.

![diff](https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/public/cypress_tutorial/diff.gif)

## Ignore areas

Mark parts of the image to leave out of the comparison.

![Ignore areas](https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/public/ignore_area.gif)
