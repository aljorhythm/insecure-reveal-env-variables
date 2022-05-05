GIT_BRANCH?=$(shell git branch --show-current)
GIT_SHA?=$(shell git rev-parse --short HEAD)

ifndef CI
	TAG := NOT-CI
else
	TAG := $(GIT_BRANCH)-$(shell date +%s)-$(GIT_SHA)
endif

IMAGE := insecure-reveal-env-variables
IMAGE_REPO := aljorhythm

IMAGE_COMMIT_TAG := $(IMAGE):$(GIT_SHA)
REPO_IMAGE_COMMIT_TAG := $(IMAGE_REPO)/$(IMAGE_COMMIT_TAG)

IMAGE_FULL_TAG := $(IMAGE):$(TAG)
REPO_IMAGE_FULL_TAG := $(IMAGE_REPO)/$(IMAGE_FULL_TAG)

image-build:
	echo $(TAG)
	docker build . --tag $(IMAGE_COMMIT_TAG)

image-push:
	docker tag $(IMAGE_COMMIT_TAG) $(REPO_IMAGE_COMMIT_TAG)
	docker push $(REPO_IMAGE_COMMIT_TAG)
	
	docker tag $(IMAGE_COMMIT_TAG) $(REPO_IMAGE_FULL_TAG)
	docker push $(REPO_IMAGE_FULL_TAG)