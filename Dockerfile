FROM alpine:3.11

RUN apk add --no-cache socat

COPY --from=docker:19.03 /usr/local/bin/docker /usr/bin/docker
ADD entry.sh /usr/bin/entry.sh

ENTRYPOINT [ "/usr/bin/entry.sh" ]
