#=============================================================================#
# File Description:
#   Used for building HEASoft Docker image.
#=============================================================================#

IMAGE_NAME = heasoft
IMAGE_VERSION = 6.28
IMAGE_LABEL = v$(IMAGE_VERSION)

DOCKER = docker
#DOCKER = sudo docker

image:
	@echo "Building Docker image ${IMAGE_NAME}:${IMAGE_LABEL}..."
	-$(DOCKER) build --network=host --build-arg version=$(IMAGE_VERSION) -t $(IMAGE_NAME):$(IMAGE_LABEL) .

latest: image
	@echo "Tagging Docker image ${IMAGE_NAME}:${IMAGE_LABEL} with latest..."
	-$(DOCKER) tag `$(DOCKER) image ls --format '{{.ID}}' $(IMAGE_NAME):$(IMAGE_LABEL)` $(IMAGE_NAME):latest
