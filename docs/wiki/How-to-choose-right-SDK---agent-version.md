The project follows [Semantic Versioning 2.0.0](https://semver.org/).

## Which version fits your server

- **Server 6.0 works with 5.x clients.** The latest 5.x release of each SDK and agent keeps working, so you can upgrade the server first and the clients later. Use the latest 5.x release, because older ones handle fewer of 6.0's statuses and error codes. An sdk-python of 4.9.0 or older does not work with 6.0.
- **6.0 clients work with server 6.0**, and need a newer runtime (below). Keep using 5.x where you cannot move the runtime.
- **A 6.0 client does not support a 5.x server.** Upgrade the server first.
- A difference in MINOR or PATCH version between server and client is fine.

## Runtime minimums of the 6.0 clients

| Client | Needs |
|---|---|
| sdk-js | Node.js 26 |
| agent-cypress | Node.js 26 |
| agent-playwright | Node.js 26 |
| agent-codeceptjs | Node.js 26 |
| sdk-python | Python 3.15 |
| sdk-java | Java 25 |
| sdk-dotnet | .NET 10 |

The 5.x releases keep their older minimums, for example Node.js 22 for agent-codeceptjs 5.x.

## Busy server

When the server answers `503` with a `Retry-After` header, the SDKs (and the agents on top of them) wait and retry up to 3 times. They report `413` and `422` with a hint and do not retry them.

Check the release notes in each client's repository for the changes in every version.
