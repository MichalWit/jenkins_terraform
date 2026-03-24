#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"${SCRIPT_DIR}/rebuild_and_run.sh" "$@"

# Wait until Gitea is serving HTTP, then run the terraform → Gitea push script.
"${SCRIPT_DIR}/wait_for_gitea.sh"

sleep 10
exec "${SCRIPT_DIR}/push_terraform_code_to_gitea.sh"
