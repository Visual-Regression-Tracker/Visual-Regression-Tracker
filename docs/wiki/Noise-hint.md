# Noise hint

Different machines draw the same page a little differently: fonts, anti-aliasing, GPU. Those differences show up as unresolved runs and bury the real changes. The rendering-noise check, also called post-analysis, labels each unresolved run so you can review the likely changes first.

## What it does and does not do

- It marks a run **Likely change** or **Likely noise**, with a score.
- It is a hint, never a verdict. It **never changes a run's status**, never approves or rejects anything, and has no effect on [Auto-approve](Auto-approve). You still decide every run.
- It can call a small real change noise, such as a single digit, a dot or a faint border. Look at the highlighted areas before approving.
- It runs only when you ask for it, on unresolved runs.

## Turn it on

The check is off by default for projects created after the upgrade to 6.0. Projects that already exist, including those upgraded from 5.x or from an earlier 6.0 release candidate, keep their setting, and that is on. To switch it off for a project, open **Settings**, go to **Post-analysis** and turn off **Stage 1 · Blur** and **Stage 2 · DINOv2 second look**, then click **Save**.

1. Open the project's **Settings** tab and go to **Post-analysis**. See [Project settings](Project-settings).
2. Turn on **Stage 1 · Blur**. It runs on the VRT server and needs nothing else.
3. Optional: turn on **Stage 2 · DINOv2 second look**. It asks the DINOv2 service about the patches the blur stage calls noise, and catches faint icons and borders. It needs the optional `dinov2` service and `DINOV2_URL`; see [Configuration](Configuration). Without the service the section says so and the blur stage alone judges the runs.
4. Click **Save**.

The thresholds **Amplitude threshold** and **Solid share, max** (blur) and **Distance threshold** (DINOv2) have defaults tuned on a benchmark of real screenshots, where noise stays below an amplitude of 51. Change them only if your environment is noisier.

The section is not available for projects that use the VLM comparator, and stage 2 needs stage 1.

## Analyse a build or a run

- **Whole build:** open the **Build menu** (the ⋯ button in the build header) and choose **Analyse rendering noise (N)**. N is the number of unresolved runs in the current list.
- **One run:** in the [Run dialog](Run-dialog), click the noise chip (**Not analysed**) and then **Analyse**. **Analyse again** repeats it.

The build header shows the progress while runs are analysed.

## Read the result

- The run list has a **Noise** column and a **Noise** filter chip with **Likely change**, **Likely noise** and **Not analysed**. Both are hidden while the check is off for the project.
- The build header says, for example, "5 of 28 unresolved look like rendering noise · analysed 28 of 28" and has **Show them**.
- In the run dialog the chip shows the label and score. Click it to see what each stage said (blur and DINOv2) and to show the areas that stage judged.
- **Can't tell** means there is no verdict, for example because the images differ in size.
- When most of a build's differences are noise, a banner suggests a renderer change and recommends filtering likely noise to review it in one pass.

The view mode **Diff without noise** in the run dialog shows what is left of the diff when the noise is masked.

## Measured quality

On a benchmark of 120 real regressions, the blur stage kept 92 of them as likely changes and the two stages together 102, with no noise from the three test environments labelled as a change. The rest are mostly small text changes and faint borders, which is why the label is only a hint.
