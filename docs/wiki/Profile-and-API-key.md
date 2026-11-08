# Profile and API key

Open **Profile** from the header menu.

## Your details

Change your **First name** and **Last name**, and your password (**New password**). With SSO the password is locked. Your role is shown, but only an admin can change it ([Users and roles](Users-and-roles)).

## API key

Your API key identifies your tests when they send screenshots. Copy it with the copy button. **Regenerate** creates a new key: CI jobs that use the current key stop working until you give them the new one.

Regenerate the key, and change your password, if you think either has leaked.

## Configuration examples

The page shows your test setup as a config file (`vrt.json`, saved in the project root) or as environment variables for your CI. They contain the API URL and the selected project; add your API key.
