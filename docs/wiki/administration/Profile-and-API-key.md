# Profile and API key

Open **Profile** from the header menu.

## Your details

- Change **First name**, **Last name** and **New password**.
- With SSO the password is locked.
- Only an admin can change your role: [Users and roles](Users-and-roles).

## API key

Your tests use it to send screenshots.

1. Click the copy button to copy it.
2. Click **Regenerate** for a new key. CI jobs with the old key stop working.

Regenerate the key and change your password if either leaked.

## Configuration examples

- A `vrt.json` file for the project root, or environment variables for CI.
- They contain the API URL and the selected project.
- Add your API key.
