#!/bin/sh
set -e

echo "Starting Gitea in bachground (&)"
/usr/bin/entrypoint &

echo "Waiting for Gitea to be ready..."
until curl -s "http://localhost:${GITEA__server__HTTP_PORT}/api/v1/version"; do
  sleep 2
done

echo "Running init script..."
sh /init.sh

echo "Waiting for all background processes to finish"
wait
