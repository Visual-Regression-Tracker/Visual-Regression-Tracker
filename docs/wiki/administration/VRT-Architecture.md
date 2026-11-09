## Components
VRT components are dockerized and can be run following the docker compose instructions in VRT homepage. Following is the flow and architecture diagram of VRT.

![VRT_Flow](https://github.com/user-attachments/assets/9eb6cefd-2281-4506-97b8-5471c798ff6e)

## Configurations
1. The configuration is taken from .env file. VRT can be run to work with hard disk images or images stored in AWS S3 based on the config in .env
2. If you want to run the components outside docker, please bring up the postgres server, VRT frontend and VRT backend and follow instructions on how to make them work together.