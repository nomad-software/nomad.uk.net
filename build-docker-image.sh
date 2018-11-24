#!/bin/bash

./build-site.sh;

echo "Deleting old docker image"
docker rmi -f $(docker images -q nomadsoftware/nomad.uk.net);

echo "Building new docker image"
docker pull nginx:alpine;
docker build -t "nomadsoftware/nomad.uk.net:latest" .;
docker images;

echo "";
echo "docker run --rm -i -t -p 80:80 nomadsoftware/nomad.uk.net:latest";

# Remote command.
#docker run --detach --name nomad.uk.net --publish 80:80 --restart always --volume /var/log/nginx:/var/log/nginx nomadsoftware/nomad.uk.net:latest
