#!/bin/bash
set -e

BASE_IMAGE="debian:bookworm-slim"
DIGEST_FILE=".last_base_digest"

# Basis-Image aktualisieren und Digest ermitteln
docker pull "$BASE_IMAGE"
CURRENT_DIGEST=$(docker inspect --format='{{index .RepoDigests 0}}' "$BASE_IMAGE")

# Prüfen, ob sich das Basis-Image geändert hat
if [ -f "$DIGEST_FILE" ]; then
    LAST_DIGEST=$(cat "$DIGEST_FILE")
    if [ "$CURRENT_DIGEST" == "$LAST_DIGEST" ]; then
        echo "Base image unchanged, skipping build."
        exit 0
    fi
fi

# Neuen Digest speichern
echo "$CURRENT_DIGEST" > "$DIGEST_FILE"

# Neues Tag erstellen: JahrMonatTagStundeMinute (z.B. 202504281530)
DATE_TAG=$(date +'%Y%m%d%H%M')

# Image bauen und taggen
docker build -t apt-cacher-ng .

# Tag auf GitHub Registry vorbereiten und pushen
docker tag apt-cacher-ng ghcr.io/mrjncsk/apt-cacher-ng:${DATE_TAG}
docker push ghcr.io/mrjncsk/apt-cacher-ng:${DATE_TAG}

# Zusätzlich "latest" aktualisieren
docker tag apt-cacher-ng ghcr.io/mrjncsk/apt-cacher-ng:latest
docker push ghcr.io/mrjncsk/apt-cacher-ng:latest
