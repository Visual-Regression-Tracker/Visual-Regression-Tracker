# Statuses

What each run and build status means.

## Run statuses

| Status | Meaning |
|---|---|
| New | No baseline yet. Approve it to create one. |
| Passed | Matches the baseline within the tolerance. |
| Unresolved | Differs from the baseline. Approve or reject it. |
| Failed | Someone rejected the run. |
| Approved | Someone approved it. It is now the baseline. |
| Auto-approved | Approved automatically. See [Auto-approve](Auto-approve). |

API values: `new`, `ok`, `unresolved`, `failed`, `approved`, `autoApproved`.

## Build statuses

- **Unresolved**: at least one run waits for review.
- **Failed**: nothing waits, but a run was rejected.
- **Passed**: all other cases.

## What decides a status

- The comparison library and its settings: [Project settings](Project-settings).
- The ignore areas of the screen: [Run dialog](Run-dialog).
- The tolerance your test sends: `diffTollerancePercent`.

The [Noise hint](Noise-hint) never changes a status.
