DEBIAN_ASDF_TAG ?= $(shell docker run --rm gcr.io/go-containerregistry/crane ls caspiandb/debian-asdf | grep -P '^asdf-[0-9.]+-' | sort -r -t- | head -n1)
TERRAFORM_RELEASE ?= $(shell cat .tool-versions | awk '$$1 == "terraform" { print $$2 }')
VERSION ?= $(shell cat .tool-versions | while read plugin version; do echo -n "$$plugin-$$version-"; done)$(DEBIAN_ASDF_TAG)

REVISION ?= $(shell git rev-parse HEAD)
BUILDDATE ?= $(shell TZ=GMT date '+%Y-%m-%dT%R:%S.%03NZ')

IMAGE_NAME ?= debian-asdf-terraform
DOCKER_REPO ?= localhost:5000/$(IMAGE_NAME)

all: build push

.PHONY: build
build: ## Build a local image without publishing artifacts.
	$(call print-target)
	docker build \
	--squash \
	--build-arg DEBIAN_ASDF_TAG=$(DEBIAN_ASDF_TAG) \
	--build-arg VERSION=$(VERSION) \
	--build-arg REVISION=$(REVISION) \
	--build-arg BUILDDATE=$(BUILDDATE) \
	--tag $(IMAGE_NAME) \
	.

.PHONY: push
push: ## Publish to container registry.
	$(call print-target)
	docker tag $(IMAGE_NAME) $(DOCKER_REPO):$(VERSION)
	docker push $(DOCKER_REPO):$(VERSION)
	docker tag $(IMAGE_NAME) $(DOCKER_REPO):terraform-$(TERRAFORM_RELEASE:v%=%)
	docker push $(DOCKER_REPO):terraform-$(TERRAFORM_RELEASE:v%=%)
	docker tag $(IMAGE_NAME) $(DOCKER_REPO):latest
	docker push $(DOCKER_REPO):latest

.PHONY: test
test: ## Test local image
	$(call print-target)
	docker run --rm -t $(IMAGE_NAME) bash -c "asdf version" | grep ^v
	docker run --rm -t ${IMAGE_NAME} aws --version | grep ^aws-cli/
	docker run --rm -t ${IMAGE_NAME} infracost --version | grep ^Infracost
	docker run --rm -t ${IMAGE_NAME} terraform --version | grep ^Terraform
	docker run --rm -t ${IMAGE_NAME} tf version | grep ^tf

.PHONY: info
info: ## Show information about version
	@echo "Version:           ${VERSION}"
	@echo "Revision:          ${REVISION}"
	@echo "Build date:        ${BUILDDATE}"

.PHONY: help
help:
	@echo "$(IMAGE_NAME)"
	@echo
	@echo Targets:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9._-]+:.*?## / {printf "  %-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

define print-target
	@printf "Executing target: \033[36m$@\033[0m\n"
endef
