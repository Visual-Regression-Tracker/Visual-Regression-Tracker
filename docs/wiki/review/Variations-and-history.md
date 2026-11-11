# Variations and history

A **variation** is one screen: its name plus branch, OS, browser, viewport, device and tags.
Each variation has a baseline that new screenshots are compared with.

## Variations tab

- Cards show a preview.
- Filter by **Branch**, **Browser**, **Device**, **OS**, **Tags** and **Viewport**.
- Click **History** on a card to see its baselines.
- A comment icon marks runs with a comment.
- A card can be deleted.

## History

**Baseline history (N)** lists every baseline version.

1. Each entry shows who approved it, when, and the status.
2. Select a version to see its image.
3. Open the run it came from.

## Merge branches

There is no merge panel in 6.0. Use the API:

- `POST /test-variations/merge` with `projectId`, `fromBranch` and `toBranch`.

On a merge run, the "merge into" chip in the [Run dialog](Run-dialog) names the target branch.
