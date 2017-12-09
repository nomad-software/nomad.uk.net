#!/bin/bash

./build-site.sh;

docker build -t "nomadsoftware/nomad.uk.net:latest" .;

# Test running it.
# docker run --rm -i -t -p 80:80 nomadsoftware/nomad.uk.net:latest;
