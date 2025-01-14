#!/bin/bash
set -ex

mkdir -p ./temp
docker build -t devsamurai .
docker run -it --rm -v $(pwd):/data --env-file ./.env devsamurai