#!/bin/bash
# Same four repository URLs as print_repo_urls.sh, as JSON (requires jq).

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
ROOT_DIR="${SCRIPT_DIR}/.."

PATH_FROM_ROOT="${ROOT_DIR}/jenkins/jenkins_home"
if [ -d "${PATH_FROM_ROOT}" ]; then
  echo "Removing existing Jenkins home directory at ${PATH_FROM_ROOT}..."
else
  echo "No existing Jenkins home directory found at ${PATH_FROM_ROOT}."
  mkdir -p "${PATH_FROM_ROOT}"
  exit 0
fi

rm -fr "${PATH_FROM_ROOT}"
mkdir "${PATH_FROM_ROOT}"
ls -la "${PATH_FROM_ROOT}"
