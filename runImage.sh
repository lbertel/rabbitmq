#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NOCOLOR='\033[0m'

imagePort="15672"
brokerPort="5672"
imageName="rabbitmq-server"
imageDockerName="rabbitmq:3.8-management-alpine"

imageID=`docker ps -a --format "{{.ID}}" --filter status=running  --filter "name=$imageName"`
if [ -z $imageID ]; then
  statusCommand=`docker run -p $imagePort:$imagePort -p $brokerPort:$brokerPort --name $imageName --restart always -d $imageDockerName` > /dev/null 2>&1
  if [ `echo $statusCommand | wc -c` -eq "65" ]; then
    firstTwelveCharacter=`printf '%s' "$statusCommand" | awk '{print substr ($0, 0, 12)}'`
    echo "The docker image ${GREEN}[$imageName]${NOCOLOR} is already running with ID: ${YELLOW}$firstTwelveCharacter${NOCOLOR}"
    exit 0
  else
    echo "Could not run docker image: ${RED}[$imageName]${NOCOLOR} 🤷"
    exit 1
  fi
else
  echo "The docker image ${GREEN}[$imageName]${NOCOLOR} is already running with ID: ${YELLOW}$imageID${NOCOLOR}"
  exit 0
fi
