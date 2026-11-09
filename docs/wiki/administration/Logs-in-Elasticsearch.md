# Logs in Elasticsearch and Kibana

For admins who monitor VRT through Kibana; Elasticsearch keeps the logs and needs more memory and CPU.

1. Clone this repository and go to its folder. In `.env`, set `JWT_SECRET` (`openssl rand -hex 32`) and check `REACT_APP_API_URL`.
2. Start one of:
   - with a new Elastic stack: `docker compose -f docker-compose.yml -f docker-compose.elastic.logging.yml up`
   - with your organisation's Elasticsearch: set its hosts in `filebeat/config/filebeat.yml` and `ELASTIC_URL` in `.env`, then `docker compose -f docker-compose.yml -f docker-compose.logging.yml up`
3. If Filebeat stops with `config file ("filebeat.yml") must be owned by the user identifier (uid=0) or root`, follow the [Elastic instructions](https://www.elastic.co/guide/en/beats/libbeat/current/config-file-permissions.html) and start again.
