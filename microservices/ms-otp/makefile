# This is a generic makefile for Node microservices. See the README for details
# on how to use it.
GIT_SHORT_SHA = $(shell git log -1 --format="%h")

# Registry and image details. These values can be overriden during builds to
# change the image tag, deploy to a different registry, etc.
DOCKER_REGISTRY ?= docker.io
IMAGE_NAMESPACE ?= microservicesplayground
IMAGE_NAME ?= $(shell basename `pwd`)
IMAGE_TAG ?= latest

default: test build

# Lint and test.
test:
	npm install
	npm run lint
	npm run test

# Builds the docker image, and explicitly tags it (avoid race conditions if the
# same machine is building many imagese).
build:
	docker build -t=$(IMAGE_NAMESPACE)/$(IMAGE_NAME):$(GIT_SHORT_SHA) .
	docker tag $(IMAGE_NAMESPACE)/$(IMAGE_NAME):$(GIT_SHORT_SHA) $(IMAGE_NAMESPACE)/$(IMAGE_NAME):$(IMAGE_TAG)

# Pushes to the configured registry.
push:
	docker tag $(IMAGE_NAMESPACE)/$(IMAGE_NAME):$(GIT_SHORT_SHA) $(DOCKER_REGISTRY)/$(IMAGE_NAMESPACE)/$(IMAGE_NAME):$(IMAGE_TAG)
	docker push $(DOCKER_REGISTRY)/$(IMAGE_NAMESPACE)/$(IMAGE_NAME):$(IMAGE_TAG)

.PHONY: test build push
