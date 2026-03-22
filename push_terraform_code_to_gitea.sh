#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "${SCRIPT_DIR}/.env"

rm -fr "${SCRIPT_DIR:?}/${G_REPO_NAME}"

git clone http://localhost:${G_HTTP_PORT}/${G_USER}/${G_REPO_NAME}.git

cp -r "${SCRIPT_DIR}"/terraform/* "${SCRIPT_DIR}/${G_REPO_NAME}"

cd "${SCRIPT_DIR}/${G_REPO_NAME}" || exit
git add .
git status -s .

git commit -m "Add terraform code"
git push origin main
