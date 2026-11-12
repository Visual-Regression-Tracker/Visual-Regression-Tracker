# How to choose the right SDK / agent version

VRT follows [Semantic Versioning 2.0.0](https://semver.org/).

## Which version fits your server

- **Use the 6.0 clients with server 6.0.** They need a newer runtime (below).
- **Server 6.0 also works with 5.x clients.** Upgrade the server first, the clients later.
  - On a 5.x client, use its latest 5.x release.
  - sdk-python 4.9.0 or older does not work with 6.0.
- **6.0 clients do not support a 5.x server.**
- A different MINOR or PATCH version is fine.

## Clients

| Client | Latest | Needs | Latest 5.x |
|---|---|---|---|
| sdk-js | 6.0.0 | Node.js 26 | 5.9.0 |
| agent-cypress | 6.0.0 | Node.js 26 | 5.9.0 |
| agent-playwright | 6.0.0 | Node.js 26 | 5.5.0 |
| agent-codeceptjs | 6.0.0 | Node.js 26 | 5.0.0 |
| sdk-python | 6.0.0 | Python 3.15 | 5.1.0 |
| sdk-java | 6.0.0 | Java 25 | 5.6.1 |
| sdk-dotnet | 6.0.0 | .NET 10 | 5.1.0 |

5.x releases keep their older minimums.

## Busy server

- On `503` with `Retry-After`, SDKs and agents wait and retry up to 3 times.
- `413` and `422` are reported with a hint, not retried.

Each client's repository has release notes.
