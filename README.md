# docker-service-proxy

Docker swarm does not allow `privileged` services (nor adding any capabilities).  
This is a small wrapper to work around it.  

More context in [this post](https://rpg.skmobi.com/posts/0x8490_privileged_swarm_service/)

## Usage

As this is a non-privileged container that can be scheduled in a swarm cluster but then starts a non-swarm container in that host, there are a few parameters that can (and should) be set, as env vars:

* PROXIED_IMAGE: the image to use for the target container
* PROXIED_FLAGS: the flags to use with docker run (optional: defaults to none, `-d` is always implicit)
* PROXIED_PULL: always pull target image before creating target container (defaults to `false`)
* PROXIED_PORT: the port in the target container (if not specific, TCP/UDP proxy won't be setup)
* PROXIED_NAME: the name of the target container (optional: defaults to normal docker random nanes)
* PROXIED_PROTO: protocol to be proxied, `udp` or `tcp` (defaults to `tcp`)

`command` attribute of this service will be passed without any modifications to the target container, making this setup easier to manager and quickly opting in or out this setup.
