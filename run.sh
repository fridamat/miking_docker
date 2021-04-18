#!/bin/bash

CONTAINER_HOME=/home/opam
DOCKER_DIR=~/frida/docker
DOCKER_BUILD_IMAGE=miking
IMAGE_VERSION=1.1

action=$1

if [ "$action" = "build" ]
then
    cd "$DOCKER_DIR"
    docker build                                     \
	   -t ${DOCKER_BUILD_IMAGE}:${IMAGE_VERSION} \
	   .
else
    docker run --tty --interactive --rm                                             \
	   --network="host"                                                         \
	   --volume ${SSH_AUTH_SOCK}:${CONTAINER_HOME}/ssh-agent.socket             \
	   --env SSH_AUTH_SOCK=${CONTAINER_HOME}/ssh-agent.socket                   \
	   --volume ${HOME}/.ssh/known_hosts:${CONTAINER_HOME}/.ssh/known_hosts:ro  \
	   --volume ${PWD}:${CONTAINER_HOME}/src:rw                                 \
	   ${DOCKER_BUILD_IMAGE}:${IMAGE_VERSION}                                   \
	   /bin/bash
fi
