#!/usr/bin/env bash
set -e
runtime_data="`pwd`/anvil-data"
if [[ "`podman unshare stat --format='%g:%u' $runtime_data`" != "1000:1000" ]]; then
  echo "Application's DB directory on host has wrong access, chowning it"
  podman unshare chown 1000:1000 -R $runtime_data
fi
podman run --rm -it --name anvil-issue-45 --publish 3030:3030/tcp -v $runtime_data:/anvil-data:Z anvil-issue-45:master ${@}
