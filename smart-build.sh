#!/bin/bash
set -e

BASE_IMAGE="debian:bookworm-slim"
DIGEST_FILE=".last_base_digest"

docker pull "$BASE_IMAGE"
CURRENT_DIGEST=$(docker inspect --format='{{index .RepoDigests 0}}' "$BASE_IMAGE")

if [ -f "$DIGEST_FILE" ]; then
    LAST_DIGEST=$(cat "$DIGEST_FILE")
    if [ "$CURRENT_DIGEST" == "$LAST_DIGEST" ]; then
        echo "Base image unchanged, skipping build."
        exit 0
    fi
fi

echo "$CURRENT_DIGEST" > "$DIGEST_FILE"

DATE_TAG=$(date +'%Y%m%d%H%M')

docker build -t apt-cacher-ng .
docker tag apt-cacher-ng ghcr.io/mrjncsk/apt-cacher-ng:${DATE_TAG}
docker push ghcr.io/mrjncsk/apt-cacher-ng:${DATE_TAG}
docker tag apt-cacher-ng ghcr.io/mrjncsk/apt-cacher-ng:latest
docker push ghcr.io/mrjncsk/apt-cacher-ng:latest
