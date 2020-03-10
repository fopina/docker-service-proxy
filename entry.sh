#!/bin/sh

set -e

if [ -z "${PROXIED_PORT}" ]; then
    echo 'PROXIED_PORT env var is required'
    exit 2
fi

C=$(docker run -d "$@")
CIP=$(docker inspect $C -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')
socat TCP4-LISTEN:${PROXIED_PORT},fork TCP4:$CIP:${PROXIED_PORT} &
docker attach $C
