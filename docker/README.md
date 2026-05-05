# Overview

Contains useful docker setup.

# Notes on using Docker

## Build a new image:

cd <directory>
docker compose build

## Run an image:

docker compose run --rm dev bash

## Exec (connect to an existing running container):

docker exec -it <container-name> bash
(find the container name with: docker ps)

## To list images:

docker images

## To list running containers:

docker ps

## Terminate a running container:

docker stop <container-name>
(find the container name with: docker ps)

