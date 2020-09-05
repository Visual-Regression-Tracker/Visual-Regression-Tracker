#!/bin/bash

DOCKER_URL=https://docs.docker.com/get-docker/
DOCKER_COMPOSE_URL=https://docs.docker.com/compose/install/

while getopts r:a: flag
do
    case "${flag}" in
        r) REACT_APP_API_URL=${OPTARG};;
        a) APP_FRONTEND_URL=${OPTARG};;
    esac
done

if [ ! -x "$(command -v docker)" ]; then
    echo "Visual Regression Tracker requires Docker. Check install docs here - $DOCKER_INSTALL_URL"
fi

if [ ! -x "$(command -v docker-compose)" ]; then
    echo "Visual Regression Tracker requires docker-compose. Check install docs here - $DOCKER_COMPOSE_URL"
fi

DOCKER_YML_URL=https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/docker-compose.yml 
DOCKER_ENV_URL=https://raw.githubusercontent.com/Visual-Regression-Tracker/Visual-Regression-Tracker/master/.env
IMAGE_UPLOADS_FOLDER=imageUploads

curl $DOCKER_YML_URL -o docker-compose.yml

curl $DOCKER_ENV_URL -o .env

ENV_FILE=.env

if [[ ! -z "$REACT_APP_API_URL" ]]; then 
    IFS=':'
    read -a url <<< "$REACT_APP_API_URL"
    unset IFS
    sed -ir "s~^[#]*\s*REACT_APP_API_URL=.*~REACT_APP_API_URL=$REACT_APP_API_URL~" $ENV_FILE
    sed -ir "s~^[#]*\s*PORT=.*~port=${url[2]}~" $ENV_FILE
    echo "Updated value for React App Api to $REACT_APP_API_URL"
fi

if [[ ! -z "$APP_FRONTEND_URL" ]]; then 
    IFS=':'
    read -a url <<< "$APP_FRONTEND_URL"
    unset IFS
    sed -ir "s~^[#]*\s*APP_FRONTEND_URL=.*~APP_FRONTEND_URL=$APP_FRONTEND_URL~" $ENV_FILE
    sed -ir "s~^[#]*\s*APP_PORT=.*~APP_PORT=${url[2]}~" $ENV_FILE
    echo "Updated value for App Frontend to $APP_FRONTEND_URL"
fi

mkdir $IMAGE_UPLOADS_FOLDER

docker-compose up