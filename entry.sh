#!/bin/sh

set -e

if [ -z "${PROXIED_PORT}" ]; then
    echo 'PROXIED_PORT env var is required'
    exit 2
fi

if [ -n "${PROXIED_NAME}" ]; then
    XARGS="--name ${PROXIED_NAME}.$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)"
fi

C=$(docker run -d $XARGS "$@")
CIP=$(docker inspect $C -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')

if [[ "${PROXIED_PROTO}" == "udp" ]]; then
    socat UDP4-LISTEN:${PROXIED_PORT},fork UDP4:$CIP:${PROXIED_PORT} &
else
    socat TCP4-LISTEN:${PROXIED_PORT},fork TCP4:$CIP:${PROXIED_PORT} &
fi

exec docker attach $C
