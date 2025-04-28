FROM debian:bookworm-slim
LABEL maintainer="MRJN <marijan@necoski.de>"
RUN apt-get update && \
    apt-get install -y --no-install-recommends apt-cacher-ng && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir -p /defaults/apt-cacher-ng && \
    cp -a /etc/apt-cacher-ng/. /defaults/apt-cacher-ng/
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
EXPOSE 3142
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["apt-cacher-ng", "-c", "/etc/apt-cacher-ng", "foreground=1"]
