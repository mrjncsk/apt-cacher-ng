#!/bin/bash
set -e

BASE_IMAGE="debian:bookworm-slim"
DIGEST_FILE=".last_base_digest"
IMAGE_NAME="ghcr.io/mrjncsk/apt-cacher-ng"

docker pull $BASE_IMAGE
CURRENT_DIGEST=$(docker inspect --format='{{index .RepoDigests 0}}' $BASE_IMAGE)

if [ -f "$DIGEST_FILE" ]; then
    LAST_DIGEST=$(cat "$DIGEST_FILE")
    if [ "$CURRENT_DIGEST" == "$LAST_DIGEST" ]; then
        echo "Base image unchanged. Skipping build."
        exit 0
    fi
fi

BUILD_TAG=$(date +"%Y%m%d%H%M")
echo "$CURRENT_DIGEST" > "$DIGEST_FILE"

docker build --build-arg BUILD_TAG=$BUILD_TAG -t $IMAGE_NAME:$BUILD_TAG -t $IMAGE_NAME:latest .

echo "${{ secrets.GITHUB_TOKEN }}" | docker login ghcr.io -u "${{ github.actor }}" --password-stdin

docker push $IMAGE_NAME:$BUILD_TAG
docker push $IMAGE_NAME:latest








