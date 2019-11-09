#!/bin/sh

nohup /usr/local/bin/dockerd --host=unix:///var/run/docker.sock --host=tcp://127.0.0.1:2375 --storage-driver=overlay&

sleep 2

timeout -t 15 sh -c "until docker info; do echo .; sleep 1; done"

exec "$@"
