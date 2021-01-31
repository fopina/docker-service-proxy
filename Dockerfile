FROM alpine:3.13

RUN apk add --no-cache socat

# at this time, latest is 20.10 and includes arm/v7 in manifest while tag "20.10" does not :mindblown:
COPY --from=docker:latest /usr/local/bin/docker /usr/bin/docker
ADD entry.sh /usr/bin/entry.sh

ENTRYPOINT [ "/usr/bin/entry.sh" ]
