#!/bin/bash

./build-site.sh;

echo "Deleting old docker image"
docker rmi $(docker images -q nomadsoftware/nomad.uk.net);

echo "Building new docker image"
docker build -t "nomadsoftware/nomad.uk.net:latest" .;
docker images;

echo -e "Run the following to test a container\n"
echo -e "docker run --rm -i -t -p 80:80 nomadsoftware/nomad.uk.net:latest\n";
