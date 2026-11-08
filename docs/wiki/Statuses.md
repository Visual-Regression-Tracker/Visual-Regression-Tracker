# Statuses

## Run statuses

| Status | Meaning |
|---|---|
| New | The screenshot has no baseline yet. Approve it to make it the baseline. |
| Passed | The screenshot matches the baseline within the tolerance. |
| Unresolved | The screenshot differs from the baseline. A person has to approve or reject it. |
| Failed | A person rejected the run. |
| Approved | A person approved it; the screenshot is now the baseline. |
| Auto-approved | Approved automatically, see [Auto-approve](Auto-approve). |

(In the API these are `new`, `ok`, `unresolved`, `failed`, `approved` and `autoApproved`.)

## Build statuses

A build is **Unresolved** while at least one of its runs waits for review, **Failed** when none waits but a run was rejected, and **Passed** otherwise.

## What decides a status

The project's comparison settings decide whether two images differ: the library and its thresholds ([Project settings](Project-settings)), the ignore areas of the screen ([Run dialog](Run-dialog)), and the tolerance your test sends with the screenshot (`diffTollerancePercent`).

The rendering-noise check never changes a status, see [Noise hint](Noise-hint).
