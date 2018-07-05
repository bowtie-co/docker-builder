#!/bin/sh

export PATH="$BOWTIE_BIN:$PATH"

dockerd >> /var/log/dockerd.log 2>&1 &

exec "$@"
