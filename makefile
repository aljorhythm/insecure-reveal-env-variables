GIT_BRANCH?=$(shell git branch --show-current)
GIT_SHA?=$(shell git rev-parse --short HEAD)

ifndef CI
	TAG := NOT-CI
else
	TAG := $(GIT_BRANCH)-$(shell date +%s)-$(GIT_SHA)
endif

IMAGE := insecure-reveal-env-variables
IMAGE_TAG := $(IMAGE):$(TAG)
IMAGE_REPO := aljorhythm
REPO_IMAGE_TAG := $(IMAGE_REPO)/$(IMAGE_TAG)

image-build:
	echo $(TAG)
	docker build . --tag $(IMAGE_TAG)

image-push:
	docker tag $IMAGE_REPO $REPO_IMAGE_TAG
	docker push $(REPO_IMAGE_TAG)