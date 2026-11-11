# Builds and runs

A **build** is one execution of your test suite. Every screenshot it sends becomes a **test run** in that build. A run is the comparison of one new screenshot with its baseline.

## Build list

The **Builds** tab lists the builds of the project, newest first. Search by CI build id. Each build shows its number, branch, status and date.

## Build header

Selecting a build shows its header with the build number, CI build id, branch and status. Chips count the runs per status: All, New, Unresolved, Failed, Approved, Auto-approved and Passed. Click a chip to filter the run list. See [Statuses](Statuses).

The **Build menu** (the ⋯ button) has:

- **Stop build**: marks a running build as finished.
- **Analyse noise (N)**: see [Noise hint](Noise-hint). Shown when the check is on for the project.
- **Edit CI build id…**
- **Delete build…**: also removes its runs.

Select several builds in the list to delete them together.

## Run list

Runs are shown as a table or a grid of cards; switch with the **Table view** and **Grid view** toggle. Every variation is its own row or card. A card shows the diff when the run has one, otherwise the screenshot.

Filter chips narrow the list by OS, browser, viewport, device and tags. Each tag chip searches its own field.

A run that has a comment shows a comment icon in the table and on the cards; hover over it or focus it to read the comment.

Click a run to open the [Run dialog](Run-dialog).

## Bulk actions

Select runs with the checkboxes. The selection bar offers:

- **Approve** and **Reject**: the result of each run is reported; a run that someone else already decided is listed as failed.
- **Analyse noise**: analyses the selected unresolved runs, see [Noise hint](Noise-hint). The rows switch to "Analysing…" at once. It is available when the check is on for the project.
- **Clear ignore areas…**
- **Download zip**
- **Delete…**

Approve and reject show **Undo** in the confirmation message.

## Live updates

The page updates while a build runs. Live updates need you to be signed in and go only to people looking at that project or build.
