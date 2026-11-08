Available since [release 4.9.0](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/releases/tag/4.9.0)

After a baseline is accepted in a feature branch and the code is merged into the project's main branch, the baseline has to be approved again.
With **Auto approve** switched on in the project's settings (section **Review**, see [Project settings](Project-settings)), VRT approves it for you.
In case no baseline or diff is found, the service tries to find an already approved baseline among other branches and compares it against the image candidate.
A test run that was approved automatically gets the status `autoApproved`, shown as **Auto-approved**.
The API logs contain trace info about the baseline taken as the reason to auto approve (`docker compose logs api`).

In 6.0 this is a setting of each project, on for new projects. The `AUTO_APPROVE_BASED_ON_HISTORY` variable from `.env` is no longer read.

## Algorithm 
When the feature is enabled and after image comparison the test run status is not `ok`, we try to auto-approve based on history.

Steps
1. Find test runs that are `approved`, have the same unique attributes and (if exists) baseline image 
1. For already approved test runs find their current baselines 
1. Compare image against baseline for already approved test

Auto approve the test run in case it matches - set the test run status `autoApproved`.

Auto-approved runs cannot be undone with **Undo**. The [Noise hint](Noise-hint) never triggers auto-approve.
