#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${SCRIPT_DIR}"

./rebuild_and_run.sh "$@"

# Wait until Gitea is serving HTTP, then run the terraform → Gitea push script.
./wait_for_gitea.sh
./push_terraform_code_to_gitea.sh
./print_urls_json.sh
