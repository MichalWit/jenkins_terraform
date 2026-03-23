#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ENV_FILE_DIR="${SCRIPT_DIR}/.."

source "${ENV_FILE_DIR}/.env"

cd "${ENV_FILE_DIR}" || exit

MESSAGE_SUFFIX=$1
MESSAGE_SUFFIX=${MESSAGE_SUFFIX:-"$(date +%Y-%m-%d-%H-%M-%S)"}

rm -fr "${ENV_FILE_DIR:?}/${G_REPO_NAME}"

git clone "http://localhost:${G_HTTP_PORT}/${G_USER}/${G_REPO_NAME}.git"
cd "${ENV_FILE_DIR}/${G_REPO_NAME}" || exit

cp -r "${ENV_FILE_DIR}"/terraform/* "${ENV_FILE_DIR}/${G_REPO_NAME}"

git add .
git status -s .

git commit -m "terraform / jenkins - [${MESSAGE_SUFFIX}]"
git push origin main
