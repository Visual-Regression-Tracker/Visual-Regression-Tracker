# Builds and runs

A **build** is one execution of your test suite. Every screenshot it sends becomes a **test run** in that build. A run is the comparison of one new screenshot with its baseline.

## Build list

The **Builds** tab lists the builds of the project, newest first. Search by CI build id. Each build shows its number, branch, status and date.

## Build header

Selecting a build shows its header with the build number, CI build id, branch and status. Chips count the runs per status: All, New, Unresolved, Failed, Approved, Auto-approved and Passed. Click a chip to filter the run list. See [Statuses](Statuses).

The **Build menu** (the ⋯ button) has:

- **Stop build**: marks a running build as finished.
- **Analyse rendering noise (N)**: see [Noise hint](Noise-hint). Shown when the check is on for the project.
- **Edit CI build id…**
- **Delete build…**: also removes its runs.

Select several builds in the list to delete them together.

When the noise check has run, the header also shows a line such as "5 of 28 unresolved look like rendering noise · analysed 28 of 28".

## Run list

Runs are shown as a table or a grid of cards; switch with the **Table view** and **Grid view** toggle. The **View** menu sets:

- **Group by**: **None**, or **Variation** by the axis chosen in [Project settings](Project-settings) (one row or card per screen),
- **Density** (table): **Comfortable**, **Standard** or **Compact**,
- **Show diff in grid** (hotkey D).

Filter chips narrow the list by OS, browser, viewport, device and tags, and by **Noise** when the noise check is on. Each tag chip searches its own field.

Click a run to open the [Run dialog](Run-dialog).

## Bulk actions

Select runs with the checkboxes. The selection bar offers:

- **Approve** and **Reject**: the result of each run is reported; a run that someone else already decided is listed as failed.
- **Clear ignore areas…**
- **Download zip**
- **Delete…**

Approve and reject show **Undo** in the confirmation message.

## Live updates

The page updates while a build runs. Live updates need you to be signed in and go only to people looking at that project or build.
