# Visual Regression Tracker

Visual Regression Tracker (VRT) is a self-hosted tool for visual testing. Your tests take screenshots and send them to VRT. VRT compares each one with its accepted baseline, and your team reviews what changed in one place: approve a change to make it the new baseline, or reject it.

This wiki describes VRT 6.0. If you are on 5.x, start with [Upgrade from 5.x](Upgrade-from-5.x).

## Start here

- [Getting started](Getting-started): install VRT, sign in, send a first screenshot. The **Help** menu in the UI has a **Documentation** link to this wiki.
- [Projects](Projects): create projects, favourites, the project switcher.
- [Builds and runs](Builds-and-runs): what a build and a test run are, filters, bulk actions.
- [Statuses](Statuses): what New, Unresolved, Approved and the others mean.

## Review

- [Run dialog](Run-dialog): view modes, Diff without noise, ignore areas, comments, Undo.
- [Noise hint](Noise-hint): flag runs that look like rendering noise.
- [Variations and history](Variations-and-history): every screen and its baseline versions.
- [Statistics](Statistics): results per build.
- [Auto-approve](Auto-approve): approve a merged branch's baselines again automatically.

## Administration

- [Project settings](Project-settings)
- [Users and roles](Users-and-roles)
- [Profile and API key](Profile-and-API-key)
- [Configuration](Configuration): environment variables.
- [Upgrade from 5.x](Upgrade-from-5.x)
- [VRT architecture](VRT-Architecture)
- [Kubernetes configuration example](Kubernetes-Configuration-Example)

## Connect your tests

- [How to choose the right SDK / agent version](How-to-choose-right-SDK---agent-version)
- [Getting started with Playwright](Getting-started-with-Playwright)
- [Getting started with Cypress](Getting-started-with-Cypress)
- [Getting started with Selenide](Getting-started-with-Selenide)
- [Storybook](Storybook)
- [How to publish VRT result in Jenkins](How-to-publish-VRT-result-in-jenkins)
