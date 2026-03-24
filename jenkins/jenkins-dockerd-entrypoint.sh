#!/bin/bash
# Start embedded Docker Engine (dockerd), then Jenkins as user jenkins.
set -e
if [ "${SKIP_DOCKERD:-0}" != "1" ]; then
  dockerd --host=unix:///var/run/docker.sock ${DOCKERD_EXTRA_ARGS:-} >>/var/jenkins_home/dockerd.log 2>&1 &
  disown $! 2>/dev/null || true
  for _ in $(seq 1 90); do
    if [ -S /var/run/docker.sock ]; then
      break
    fi
    sleep 1
  done
  if [ ! -S /var/run/docker.sock ]; then
    echo "ERROR: dockerd did not create /var/run/docker.sock (see /var/jenkins_home/dockerd.log)" >&2
    exit 1
  fi
  chmod 666 /var/run/docker.sock 2>/dev/null || true
fi
exec gosu jenkins /usr/local/bin/jenkins.sh "$@"
