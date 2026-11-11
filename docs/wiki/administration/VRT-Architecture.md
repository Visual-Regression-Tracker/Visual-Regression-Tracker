# VRT architecture

VRT runs as Docker containers. Start them with Docker Compose: [Getting started](Getting-started).

![VRT_Flow](https://github.com/user-attachments/assets/9eb6cefd-2281-4506-97b8-5471c798ff6e)

## Configuration

- Settings come from `.env`: [Configuration](Configuration).
- Images go to local disk or AWS S3.

To run without Docker:

1. Start PostgreSQL, the VRT backend and the VRT frontend.
2. Point them at each other with the same settings.
