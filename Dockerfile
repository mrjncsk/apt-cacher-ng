FROM debian:bookworm-slim
LABEL maintainer="mrjncsk"
ARG BUILD_TAG
LABEL org.opencontainers.image.created=$BUILD_TAG

RUN apt-get update \
    && apt-get install -y apt-cacher-ng \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN test -d /etc/apt-cacher-ng || (echo "Missing config dir!" && exit 1)

EXPOSE 3142

CMD ["apt-cacher-ng", "-foreground"]
