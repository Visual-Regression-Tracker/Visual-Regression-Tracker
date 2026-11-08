Available since [release 4.9.0](https://github.com/Visual-Regression-Tracker/Visual-Regression-Tracker/releases/tag/4.9.0)

After baseline is accepted in feature branch and code is merged into project main branch there is a need to approve it again.
With AUTO_APPROVE_BASED_ON_HISTORY variable added in .env file you could enable auto approve feature.
In case no baseline or diff found service is trying to find already approved baseline among other branches and compare it against image candidate.
Test run that was approved automatically get's autoApproved status.
docker-compose logs will contains trace info about baseline taken as reason to auto approve

## Algorithm 
When feature is enabled and after image comparison test run status is not `ok` we gonna try to auto-approve based on history.

Steps
1. Find test runs that are `approved`, have the same unique attributes and (if exists) baseline image 
1. For already approved test runs find their current baselines 
1. Compare image agains baseline for already approved test

Auto approve test run in case it matches - set test run status `autoApprove`.