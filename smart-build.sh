#!/bin/bash
BASE_IMAGE="debian:bookworm-slim"
DIGEST_FILE=".last_base_digest"
docker pull $BASE_IMAGE
CURRENT_DIGEST=$(docker inspect --format='{{index .RepoDigests 0}}' $BASE_IMAGE)

if [ -f "$DIGEST_FILE" ]; then
    LAST_DIGEST=$(cat "$DIGEST_FILE")
    if [ "$CURRENT_DIGEST" == "$LAST_DIGEST" ]; then
        echo "Image not changed."
        exit 0
    fi
fi
echo "$CURRENT_DIGEST" > "$DIGEST_FILE"
docker build -t apt-cacher-ng .
