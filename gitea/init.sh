#!/bin/sh
set -e

echo "Waiting for Gitea to start..."
until [ -f /data/gitea/gitea.db ]; do sleep 2; done

HOST="http://localhost:${GITEA__server__HTTP_PORT}"

until curl -s "${HOST}/api/health" >/dev/null; do
  sleep 2
done

cat /etc/passwd
echo "id:  $(id)"

su git -c "gitea admin user create --username ${G_USER} --password ${G_PASS} --email ${G_EMAIL} --admin"

# wait for Gitea to be ready

curl -X POST "${HOST}/api/v1/admin/users/${G_USER}/repos" \
  -u "${G_USER}:${G_PASS}" \
  -H "Content-Type: application/json" \
  -d "{
    \"name\": \"${G_REPO_NAME}\",
    \"description\": \"Terraform project\",
    \"private\": false,
    \"auto_init\": true,
    \"default_branch\": \"main\",
    \"readme\": \"Default\"
  }"
