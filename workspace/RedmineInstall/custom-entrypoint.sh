#!/bin/bash
chmod -R o-w /usr/local/bundle || true
chmod +t /usr/local/bundle/extensions/x86_64-linux/* || true
exec /docker-entrypoint.sh "$@"
