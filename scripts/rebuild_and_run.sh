#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DC_FILE="$SCRIPT_DIR/../docker-compose.yml"
SERVICE=$1

docker-compose -f "${DC_FILE}" stop $SERVICE
docker-compose -f "${DC_FILE}" rm -f $SERVICE
docker-compose -f "${DC_FILE}" build --no-cache $SERVICE
docker-compose -f "${DC_FILE}" up $SERVICE -d # -d to run in detached mode
