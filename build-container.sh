#!/bin/bash

./build-site.sh;

docker build -t "nomad.uk.net:latest" .;

# Test running it.
docker run --rm -i -t -p 80:80 nomad.uk.net:latest;
