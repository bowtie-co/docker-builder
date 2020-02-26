#!/bin/sh

# Attempt to initialize Docker daemon during entrypoint (skipped during CodeBuild, should be included in buildspec.yml)
$BOWTIE_BIN/docker-init

exec "$@"
