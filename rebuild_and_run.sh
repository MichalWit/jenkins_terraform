#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

docker-compose stop $1
docker-compose rm -f $1
docker-compose build --no-cache $1
docker-compose up $1
