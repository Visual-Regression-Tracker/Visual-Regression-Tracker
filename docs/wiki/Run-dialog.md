# Run dialog

Click a run in a build to open the run dialog. It shows the baseline and the new screenshot, and is where you approve or reject.

## Header

- The position in the build, with **Previous run** and **Next run** (left and right arrow keys).
- The run status, and how much differs: "Diff 0.4% · tolerance 0.1%". Hover for the full text. The tolerance is the `diffTollerancePercent` your test sends with the screenshot.
- A rendering-noise chip, when the check is on for the project: see [Noise hint](Noise-hint).
- **Comments**: free text saved with the run.
- **Close**.

If the baseline or the new image cannot be loaded, or the sizes differ, a message above the images says so.

## View modes

| Mode | Shows |
|---|---|
| **Side by side** | Baseline and new screenshot next to each other. |
| **Diff** | The new screenshot with the differing pixels highlighted (hotkey D). |
| **Diff without noise** | The diff with rendering noise masked, so what is left is more likely a real change. |
| **Fade** | The new screenshot faded out to show the baseline through it, with a **Difference blend** option. |

Zoom with the controls in the footer: **Zoom in**, **Zoom out**, **Fit into screen**, **Original size**.

### Diff without noise

This view is computed in your browser from the baseline and the new screenshot. It is a reading aid, not a result: the run keeps its status. A banner warns when faint changes may be hidden, or when DINOv2 sees a change this view hides. The mode is not available for images with semi-transparent pixels, images of different sizes, or very large images.

## Ignore areas

Parts of a screen that change on their own, such as dates or ads, can be left out of the comparison.

1. Click **Edit areas**.
2. Pick the area type: **Ignore Areas** (masked out) or **Compare Area** (only this part is compared; it is saved as ignore areas for the rest).
3. Click **Draw** and drag on the image. **Delete selected** removes the selected area, **Clear all** removes all of them.
4. Click **Save**, or **Cancel**.

**Apply to whole build** re-compares all images in the current build with the selected ignore area taken into account.

The **Ignore areas (N)** chip shows or hides the saved areas on the image. Ignore areas belong to the screen, so they apply to its next runs as well.

## Approve, reject and Undo

The footer has **Approve** and **Reject** for runs that wait for review (hotkeys A and X). The checkbox **Go to the next after Approve/Reject** moves on to the next run.

- For a feature-branch run, a chip shows "merge into: <branch>": approving updates the baseline of that branch.
- When the project has **Bulk approve/reject variations** on, **Approve variations…** and **Reject variations…** open all matching variations of the screen (for example every locale) in one dialog. See [Project settings](Project-settings).

After a decision, a message shows **Undo**; the footer of a decided run has **Undo approval** or **Undo rejection**. Undo puts the run back to its earlier status. Undoing a feature-branch approval also restores that branch's ignore areas and comment. Approvals made before 6.0 are undone without restoring ignore areas and comment. Auto-approved runs cannot be undone this way.

If a teammate decided on the same run a moment earlier, VRT tells you, and only the decision that took effect can be undone.
