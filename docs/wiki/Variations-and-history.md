# Variations and history

A **variation** is one screen as VRT tracks it: the screenshot name together with the branch, OS, browser, viewport, device and custom tags. A variation appears when a build sends its first screenshot of a screen. Each variation has a baseline, the screenshot new ones are compared with.

## Variations tab

The **Variations** tab lists the variations of the project as cards with a preview. Filter them by **Branch**, **Browser**, **Device**, **OS**, **Tags** and **Viewport**, and set **Per page**.

Click **History** on a card for the history of that variation. A card can also be deleted.

## History

The history page, **Baseline history (N)**, lists every baseline version of the variation. Each entry shows who approved it, when, and the status. Select a version to see its image, and open the test run it came from.

## Merging branches

The UI has no merge panel in 6.0. To merge one branch's baselines into another, call the API: `POST /test-variations/merge` with `projectId`, `fromBranch` and `toBranch`. On a merge run, the "merge into" chip in the [Run dialog](Run-dialog) shows which branch's baseline approving updates.
