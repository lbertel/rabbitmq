#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NOCOLOR='\033[0m'

imageName="rabbitmq-server"

imageID=`docker ps -a --format "{{.ID}}" --filter status=running  --filter "name=$imageName"`
if [ -z $imageID ]; then
  echo "${RED}[$imageName]${NOCOLOR} docker image is not running. 🤷"
  exit 1
else
  docker stop $imageID > /dev/null 2>&1
  statusDockerStop=$?
  if [ $statusDockerStop -eq  "1" ]; then
    echo "The ${RED}[$imageName]${NOCOLOR} image could not be stopped"
    exit 1
  else
    echo "The ${GREEN}[$imageName]${NOCOLOR} docker image stopped. ✔️"
  fi
  docker rm $imageID > /dev/null 2>&1
  statusDockerRm=$?
  if [ $statusDockerRm -eq  "1" ]; then
    echo "The ${RED}[$imageName]${NOCOLOR} image could not be removed"
    exit 1
  else
    echo "The ${GREEN}[$imageName]${NOCOLOR} docker image removed. ✔️"
  fi
  exit 0
fi
