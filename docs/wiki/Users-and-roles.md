# Users and roles

## Roles

| Role | Can |
|---|---|
| Admin | Everything an Editor can do, plus manage users and roles. |
| Editor | Approve, reject and undo, edit ignore areas, create projects and change their settings. |
| Guest | View only. New sign-ups start here. |

## Users page

Admins see **Users** in the header menu. The list has a search box (name or email), a **Role** filter, and the columns **Person**, **Role** and **Joined**. The roles are explained in a card beside the list.

- **Change role**: select users, then pick a role in the selection bar, or change it in the **Role** column.
- **Delete**: removes the selected users.

## Sign-in methods

- Password: users register themselves on the sign-in page and start as Guest. Set `REGISTRATION_ENABLED=false` to hide sign-up; an admin, LDAP or SSO then creates the users.
- LDAP: enabled with the `LDAP_*` settings.
- SSO (OpenID Connect): enabled with the `OIDC_*` settings. Users are created on their first login and their role comes from the identity provider on every login. Password login and registration are off while SSO is on.

See [Configuration](Configuration).
