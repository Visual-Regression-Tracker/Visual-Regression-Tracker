# Auto-approve

After a branch is merged, VRT can approve its baselines again for you. Available since 4.9.0.

## Turn it on

1. Open the project's **Settings** tab, section **Review**.
2. Turn on **Auto approve**. It is on for new projects.
3. Click **Save**.

See [Project settings](Project-settings). The `AUTO_APPROVE_BASED_ON_HISTORY` variable is no longer read.

## How it works

After a comparison, if the run is not `ok`:

1. Find approved runs of the same screen.
2. Find their current baselines.
3. Compare the new image with them.

On a match the run gets the status **Auto-approved** (`autoApproved`).

## Good to know

- Auto-approved runs cannot be undone.
- The [Noise hint](Noise-hint) never triggers it.
- The API logs show the baseline used: `docker compose logs api`.
