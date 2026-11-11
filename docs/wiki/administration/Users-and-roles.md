# Users and roles

## Roles

| Role | Can |
|---|---|
| Admin | Everything an Editor can, plus manage users and roles. |
| Editor | Approve, reject, undo, edit ignore areas, create projects, change settings. |
| Guest | View only. New sign-ups start here. Its API key gets HTTP 403. |

The API key your CI uses must belong to an Editor or Admin.

## Users page

Admins open **Users** in the header menu.

- Search by name or email. Filter by **Role**.
- **Change role**: select users and pick a role, or use the **Role** column.
- **Delete**: removes the selected users.

Admins cannot create users in the UI.

## Sign-in methods

- **Password:** users register themselves and start as Guest.
  - `REGISTRATION_ENABLED=false` turns off sign-up.
  - Users then come only from LDAP or SSO.
- **LDAP:** the `LDAP_*` settings.
- **SSO (OpenID Connect):** the `OIDC_*` settings.
  - Users are created at first login.
  - The role comes from the provider at every login.
  - Password login and sign-up are off.

See [Configuration](Configuration).
