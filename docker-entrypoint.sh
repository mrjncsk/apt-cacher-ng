#!/bin/bash
set -e

# Wenn /etc/apt-cacher-ng leer ist, kopiere die Default-Configs
if [ ! "$(ls -A /etc/apt-cacher-ng)" ]; then
    echo "No configuration found, restoring defaults..."
    cp -a /defaults/apt-cacher-ng/. /etc/apt-cacher-ng/
fi

# Danach den eigentlichen Container-Prozess starten
exec "$@"
