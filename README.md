# Dockerized Apt Cacher NG
## Features
- Docker Container
- Debian Slim
- Apt Cacher NG
- Port 3142
## Docker
```bash
docker run -d \
  --name apt-cacher-ng \
  -p 3142:3142 \
  -v ./apt-cache:/var/cache/apt-cacher-ng \
  -v ./apt-config:/etc/apt-cacher-ng \
  ghcr.io/mrjncsk/apt-cacher-ng:latest
```
## Compose
```yml
services:
  apt-cacher-ng:
    image: ghcr.io/mrjncsk/apt-cacher-ng:latest
    container_name: apt-cacher-ng
    ports:
      - "3142:3142"
    volumes:
      - ./apt-cache:/var/cache/apt-cacher-ng
      - ./apt-config:/etc/apt-cacher-ng
    restart: unless-stopped
```
## Apt Cacher Infos
https://wiki.debian.org/AptCacherNg




