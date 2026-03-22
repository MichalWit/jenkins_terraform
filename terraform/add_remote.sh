#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "${SCRIPT_DIR}/../.env"

# let's add gitea remote
git remote add origin http://localhost:${GITEA_PORT}/${GITEA_USER}/${GITEA_REPO_NAME}.git
