#!/bin/sh

set -e

if [ -z "${PROXIED_PORT}" ]; then
    echo 'PROXIED_PORT env var is required'
    exit 2
fi

C=$(docker run -d "$@")
CIP=$(docker inspect $C -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')

if [[ "${PROXIED_PROTO}" == "udp" ]]; then
    socat UDP4-RECVFROM:${PROXIED_PORT},fork UDP4-SENDTO:$CIP:${PROXIED_PORT} &
else
    socat TCP4-LISTEN:${PROXIED_PORT},fork TCP4:$CIP:${PROXIED_PORT} &
fi

docker attach $C
