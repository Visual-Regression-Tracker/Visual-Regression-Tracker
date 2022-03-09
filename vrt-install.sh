#!/bin/bash

DOCKER_URL=https://docs.docker.com/get-docker/
DOCKER_COMPOSE_URL=https://docs.docker.com/compose/install/

DOCKER_YML_URL=https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/docker-compose.yml 
DOCKER_ENV_URL=https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/.env
ENV_FILE=.env

REACT_APP_API_URL=
APP_FRONTEND_URL=
POSTGRES_FOLDER=
JWT_SECRET=`cat /dev/urandom | env LC_CTYPE=en.US.UTF-8 tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`

usage()
{
    cat <<EOF
Installs the Visual Regression Tracker

Usage: ./vrt-install.sh

Arguments:
    -h | --help
    -a | --frontend-url <url>   Set the Front-end url. Default: http://localhost:8080
    -r | --backend-url <url>    Set the API url. Default: http://localhost:4200
    --jwt-secret <secret>       Set the JWT secret. Default: randomly generated

EOF

    exit 2
}

while getopts hr:a:d:-: flag
do
    case "${flag}" in
        \?|h) usage;;
        r) REACT_APP_API_URL=${OPTARG};;
        a) APP_FRONTEND_URL=${OPTARG};;
        -)
            case "${OPTARG}" in
                help) usage;;
                frontend-url) APP_FRONTEND_URL=${!OPTIND}; shift;;
                backend-url) REACT_APP_API_URL=${!OPTIND}; shift;;
                jwt-secret) JWT_SECRET=${!OPTIND}; shift;;
                *)
                    echo "Illegal option: ${OPTARG}"
                    usage
                ;;
            esac
        ;;
    esac
done

if [ ${OPTIND} -le $# ]; then
    echo "Illegal argument ${!OPTIND}"
    usage
fi

if [ ! -x "$(command -v docker)" ]; then
    echo "Visual Regression Tracker requires Docker. Check install docs here - $DOCKER_INSTALL_URL"
fi

if [ ! -x "$(command -v docker-compose)" ]; then
    echo "Visual Regression Tracker requires docker-compose. Check install docs here - $DOCKER_COMPOSE_URL"
fi

echo " "
echo Downloading docker files
curl $DOCKER_YML_URL -s -o docker-compose.yml
curl $DOCKER_ENV_URL -s -o .env

echo " "
echo Applying configuration
if [[ ! -z "${REACT_APP_API_URL}" ]]; then
    echo Backend API URL: $REACT_APP_API_URL
    sed -ir "s~^[#]*\s*REACT_APP_API_URL=.*~REACT_APP_API_URL=${REACT_APP_API_URL}~" $ENV_FILE

    APP_PORT=`echo "$REACT_APP_API_URL" | sed -e 's,^.*:,:,g' -e 's,.*:\([0-9]*\).*,\1,g' -e 's,[^0-9],,g'`
    echo Backend API port: ${APP_PORT:-80}
    sed -ir "s~^[#]*\s*APP_PORT=.*~APP_PORT=${APP_PORT:-80}~" $ENV_FILE
fi

if [[ ! -z "${APP_FRONTEND_URL}" ]]; then
    echo Frontend URL: $APP_FRONTEND_URL
    sed -ir "s~^[#]*\s*APP_FRONTEND_URL=.*~APP_FRONTEND_URL=${APP_FRONTEND_URL}~" $ENV_FILE

    PORT=`echo "$APP_FRONTEND_URL" | sed -e 's,^.*:,:,g' -e 's,.*:\([0-9]*\).*,\1,g' -e 's,[^0-9],,g'`
    echo Frontend port: ${PORT:-80}
    sed -ir "s~^[#]*\s*PORT=.*~PORT=${PORT:-80}~" $ENV_FILE
fi

if [[ ! -z "${JWT_SECRET}" ]]; then
    echo JWT secret: $JWT_SECRET
    sed -ir "s~^[#]*\s*JWT_SECRET=.*~JWT_SECRET=${JWT_SECRET}~" $ENV_FILE
fi

rm -f .envr

echo " "
echo Starting docker
docker-compose up 
