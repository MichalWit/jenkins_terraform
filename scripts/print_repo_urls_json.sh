#!/bin/bash
# Same four repository URLs as print_repo_urls.sh, as JSON (requires jq).

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
ENV_FILE_DIR="${SCRIPT_DIR}/.."

source "${ENV_FILE_DIR}/.env"

jq -n \
  --arg ssh_gitea "git@gitea:${G_USER}/${G_REPO_NAME}.git" \
  --arg ssh_localhost "git@localhost:${G_USER}/${G_REPO_NAME}.git" \
  --arg http_gitea "http://gitea:${G_HTTP_PORT}/${G_USER}/${G_REPO_NAME}.git" \
  --arg http_localhost "http://localhost:${G_HTTP_PORT}/${G_USER}/${G_REPO_NAME}.git" \
  --arg ui_gitea "http://localhost:${G_HTTP_PORT}" \
  --arg ui_jenkins "http://localhost:${J_HTTP_PORT}" \
  '{
    ssh: { gitea: $ssh_gitea, localhost: $ssh_localhost },
    http: { gitea: $http_gitea, localhost: $http_localhost },
    ui: { gitea: $ui_gitea, jenkins: $ui_jenkins }
  }'
