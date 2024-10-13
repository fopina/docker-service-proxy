FROM debian:bookworm-slim

ARG TARGETARCH

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
 && apt-get install -y --no-install-recommends \
        curl \
        gnupg2 \
        socat \
        ca-certificates \
        simpleproxy \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean

RUN curl -fsSL "https://download.docker.com/linux/debian/gpg" | apt-key add -qq - >/dev/null \
 && echo "deb [arch=${TARGETARCH}] https://download.docker.com/linux/debian bookworm stable" > /etc/apt/sources.list.d/docker.list \
 && apt-get update -qq >/dev/null \
 && apt-get install -y --no-install-recommends docker-ce-cli \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean

RUN apt update && apt install -y docker-ce-cli simpleproxy

ADD entry.sh /usr/bin/entry.sh

ENTRYPOINT [ "/usr/bin/entry.sh" ]
