FROM alpine:3.13

RUN apk add --no-cache socat

COPY --from=docker:20.10 /usr/local/bin/docker /usr/bin/docker
ADD entry.sh /usr/bin/entry.sh

ENTRYPOINT [ "/usr/bin/entry.sh" ]
