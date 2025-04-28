FROM debian:bookworm-slim
LABEL maintainer="MRJN <marijan@necoski.de>"
RUN apt-get update && \
    apt-get install -y --no-install-recommends apt-cacher-ng && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
EXPOSE 3142
CMD ["apt-cacher-ng", "-c", "/etc/apt-cacher-ng", "foreground=1"]
