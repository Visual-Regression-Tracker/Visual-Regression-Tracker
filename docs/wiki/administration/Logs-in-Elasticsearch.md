# Logs in Elasticsearch and Kibana

For admins who watch VRT in Kibana. Elasticsearch needs extra memory and CPU.

1. Clone this repository and open its folder.
2. In `.env`, set `JWT_SECRET` (`openssl rand -hex 32`) and check `REACT_APP_API_URL`.
3. Start one of:
   - New Elastic stack: `docker compose -f docker-compose.yml -f docker-compose.elastic.logging.yml up`
   - Your Elasticsearch: set hosts in `filebeat/config/filebeat.yml` and `ELASTIC_URL` in `.env`, then run `docker compose -f docker-compose.yml -f docker-compose.logging.yml up`
4. If Filebeat fails with `config file ("filebeat.yml") must be owned by ... root`, fix the owner and start again.
   See the [Elastic instructions](https://www.elastic.co/guide/en/beats/libbeat/current/config-file-permissions.html).
