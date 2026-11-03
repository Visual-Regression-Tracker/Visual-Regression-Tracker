#!/bin/bash
# Copies the Visual Regression Tracker database in ./db from an older PostgreSQL to the one in docker-compose.yml
set -euo pipefail

OLD_CONTAINER=vrt-pg-upgrade-old

if [ ! -f docker-compose.yml ] || [ ! -f .env ]; then
    echo "Run this in the folder with docker-compose.yml and .env"
    exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
    echo "This needs Docker Compose v2 (docker compose). Check install docs here - https://docs.docker.com/compose/install/"
    exit 1
fi

NEW_IMAGE=$(docker compose config --images postgres)

# ./db is owned by the container's postgres user, so read it from a container
OLD_VERSION=$([ -d db ] && docker run --rm -v "$PWD/db:/db" --entrypoint cat "${NEW_IMAGE}" /db/PG_VERSION 2>/dev/null || true)
if [ -z "${OLD_VERSION}" ]; then
    echo "No database from an older PostgreSQL in ./db, nothing to upgrade"
    exit 0
fi

OLD_DIR=db-pg${OLD_VERSION}
if [ -e "${OLD_DIR}" ]; then
    echo "${OLD_DIR} already exists, remove it or move it away first"
    exit 1
fi

cleanup()
{
    # a clean shutdown keeps the old data ready to roll back to
    docker stop -t 60 "${OLD_CONTAINER}" >/dev/null 2>&1 || true
}
failed()
{
    echo " "
    echo "Upgrade failed, the old data is untouched in ./${OLD_DIR}. To go back:"
    echo "  docker compose down && mv db db-new && mv ${OLD_DIR} db"
    echo "then put back the previous docker-compose.yml and run: docker compose up -d"
}
trap cleanup EXIT

echo "Stopping Visual Regression Tracker"
docker compose down

echo " "
echo "Moving the PostgreSQL ${OLD_VERSION} data to ./${OLD_DIR}"
mv db "${OLD_DIR}"
trap failed ERR

docker run -d --rm --name "${OLD_CONTAINER}" -v "$PWD/${OLD_DIR}:/var/lib/postgresql/data" "postgres:${OLD_VERSION}" >/dev/null
for _ in $(seq 60); do
    docker exec "${OLD_CONTAINER}" pg_isready -q && break
    sleep 1
done
docker exec "${OLD_CONTAINER}" pg_isready -q

echo " "
echo "Creating the new database"
docker compose up -d --wait postgres
read -r DB_USER DB_NAME < <(docker compose exec -T postgres sh -c 'echo "$POSTGRES_USER $POSTGRES_DB"')

echo " "
echo "Copying ${DB_NAME} to ${NEW_IMAGE}"
# the newer pg_dump reads the old server, as the PostgreSQL docs recommend
docker run --rm --network "container:${OLD_CONTAINER}" "${NEW_IMAGE}" \
    pg_dump -h localhost -U "${DB_USER}" -Fc "${DB_NAME}" \
    | docker compose exec -T postgres pg_restore -U "${DB_USER}" -d "${DB_NAME}" --exit-on-error
docker compose exec -T postgres vacuumdb -U "${DB_USER}" -d "${DB_NAME}" --analyze-only --quiet

echo " "
echo "Starting Visual Regression Tracker"
docker compose up -d

echo " "
echo "Done. Once it works, delete ./${OLD_DIR} (it may need sudo)"
