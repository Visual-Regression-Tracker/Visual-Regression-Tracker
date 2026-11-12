# How to choose the right SDK / agent version

VRT follows [Semantic Versioning 2.0.0](https://semver.org/).

## Which version fits your server

- **Server 6.0 works with 5.x clients.** Upgrade the server first, the clients later.
  - Use the latest 5.x release of each client.
  - sdk-python 4.9.0 or older does not work with 6.0.
- **6.0 clients work with server 6.0.** They need a newer runtime.
- **6.0 clients do not support a 5.x server.**
- A different MINOR or PATCH version is fine.

## Runtime minimums of 6.0 clients

| Client | Needs |
|---|---|
| sdk-js | Node.js 26 |
| agent-cypress | Node.js 26 |
| agent-playwright | Node.js 26 |
| agent-codeceptjs | Node.js 26 |
| sdk-python | Python 3.15 |
| sdk-java | Java 25 |
| sdk-dotnet | .NET 10 |

5.x releases keep their older minimums.

## Busy server

- On `503` with `Retry-After`, SDKs and agents wait and retry up to 3 times.
- `413` and `422` are reported with a hint, not retried.

Each client's repository has release notes.
