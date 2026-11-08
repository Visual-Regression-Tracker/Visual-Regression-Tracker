# Project settings

Open a project and choose the **Settings** tab, or click **Project settings** on its card. Change what you need and click **Save**, or **Discard changes**. Editors and admins only.

## General

- **Project name**
- **Main branch**: other branches are compared with its baselines.
- **Builds to keep**: when a project has more builds, the oldest are removed with their runs.
- **Max branch lifetime, days**: branches not used for this long are cleaned up.

## Review

- **Auto approve**: approve a run automatically when it looks the same as an earlier or already-approved baseline of this screen. See [Auto-approve](Auto-approve).
- **Bulk approve/reject variations**: review the variations of a screen (for example all locales) in one dialog. Only variations with the same change are pre-selected.
- **Variation axis**: which of `customTags`, `os`, `device`, `viewport` or `browser` differs inside a group. Runs that match on everything except this axis are grouped in the run list and reviewed together.

## Comparison

**Image comparison library**: `pixelmatch` (default), `lookSame`, `odiff` or `vlm`. Changing the library resets its settings.

- **pixelmatch**: **Pixel diff threshold** (0 to 1), **Ignore anti-aliasing**, **Allow diff dimensions**.
- **lookSame**: **Strict**, **Tolerance**, **Antialiasing tolerance**, **Ignore anti-aliasing**, **Ignore caret**, **Allow diff dimensions**.
- **odiff**: **Pixel diff threshold**, **Ignore anti-aliasing**, **Fail on layout diff**, **Output diff mask**.
- **vlm**: pixelmatch plus a vision language model (Ollama or Gemini) that judges the difference. The Ollama address is set in [Configuration](Configuration).

Comparison settings change which runs become unresolved. The tolerance your tests send with a screenshot (`diffTollerancePercent`) still applies.

## Post-analysis

The rendering-noise check: Stage 1 · Blur, Stage 2 · DINOv2 second look and their thresholds. See [Noise hint](Noise-hint). It is off for new projects.
