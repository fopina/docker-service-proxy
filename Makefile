IMAGE = fopina/swarm-service-proxy
VERSION = 1

build:
	docker build -t ${IMAGE}:test \
				 .
release:
	docker buildx build \
           --platform linux/amd64,linux/arm64,linux/arm/v7 \
           --build-arg VERSION=${VERSION} \
           --push \
           -t ${IMAGE}:${VERSION} \
           -t ${IMAGE}:latest \
           .

test: build
	docker run --rm \
	           -ti \
			   -v /var/run/docker.sock:/var/run/docker.sock \
			   -p 9999:80 \
			   -e PROXIED_PORT=80 \
			   ${IMAGE}:test \
			   nginx:1.17
