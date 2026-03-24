#!/usr/bin/env bash
# Block until Gitea answers HTTP (same check as gitea/entrypoint.sh: /api/v1/version).
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="${SCRIPT_DIR}/.."
# shellcheck source=/dev/null
source "${ROOT}/.env"

REPO_URL=$("${SCRIPT_DIR}"/print_urls_json.sh | jq -r '.http.localhost')

MAX_ATTEMPTS=90
SLEEP_SEC=1

echo "Waiting for Gitea repository at ${REPO_URL} [max ${MAX_ATTEMPTS} seconds] ..."

for ((i = 1; i <= MAX_ATTEMPTS; i++)); do
  if curl -sfS --connect-timeout 2 --max-time 10 "${REPO_URL}" >/dev/null; then
    echo "Gitea is up (GET ${REPO_URL} OK)."
    exit 0
  fi
  echo "  attempt ${i}/${MAX_ATTEMPTS} — not ready yet, sleeping ${SLEEP_SEC}s"
  sleep "${SLEEP_SEC}"
done

echo "Waiting for branch 'main' on ${REPO_URL} [max ${MAX_ATTEMPTS} seconds] ..."

for ((i = 1; i <= MAX_ATTEMPTS; i++)); do
  refs=$(git ls-remote "$REPO_URL" refs/heads/main 2>/dev/null || true) # 2>/dev/null --> silence error messages
  if [ -n "$refs" ]; then
    echo "OK: branch 'main' exists on ${REPO_URL}"
    exit 0
  fi
  echo "  attempt ${i}/${MAX_ATTEMPTS} — main not present yet, sleeping ${SLEEP_SEC}s"
  sleep "${SLEEP_SEC}"
done

echo "FAIL: branch 'main' still missing after ${MAX_ATTEMPTS} attempts: ${REPO_URL}" >&2
exit 1
