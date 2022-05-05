GIT_BRANCH?=$(shell git branch --show-current)
GIT_SHA?=$(shell git rev-parse --short HEAD)

IMAGE := insecure-reveal-env-variables
IMAGE_REPO := aljorhythm

ifndef CI
	IMAGE_COMMIT_TAG := $(IMAGE):$(GIT_SHA)
else
	IMAGE_COMMIT_TAG := $(IMAGE):NOT_CI
endif

REPO_IMAGE_COMMIT_TAG := $(IMAGE_REPO)/$(IMAGE_COMMIT_TAG)

ifndef CI
	IMAGE_FULL_TAG := $(IMAGE):NOT_CI-$(shell date +%s)-$(GIT_SHA)
else
	IMAGE_FULL_TAG := $(IMAGE):$(GIT_BRANCH)-$(shell date +%s)-$(GIT_SHA)
endif

REPO_IMAGE_FULL_TAG := $(IMAGE_REPO)/$(IMAGE_FULL_TAG)

image-build:
	docker build . --tag $(IMAGE_COMMIT_TAG)

image-push:
	docker tag $(IMAGE_COMMIT_TAG) $(REPO_IMAGE_COMMIT_TAG)
	docker push $(REPO_IMAGE_COMMIT_TAG)

	docker tag $(IMAGE_COMMIT_TAG) $(REPO_IMAGE_FULL_TAG)
	docker push $(REPO_IMAGE_FULL_TAG)