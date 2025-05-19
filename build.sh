#! /bin/bash

#define Variables

DOCKER_USERNAME="krtech26"
DEV_REPO_NAME="react-site-app-dev"
PROD_REPO_NAME="react-site-app-prod"
DEV_IMAGE_NAME="$DOCKER_USERNAME/$DEV_REPO_NAME"
PROD_IMAGE_NAME="$DOCKER_USERNAME/$PROD_REPO_NAME"
DEV_TAG="dev"
PROD_TAG="prod"

#build the docker image to Dev Repo
echo " Building Docker Image..."
docker build -t $DEV_IMAGE_NAME:$DEV_TAG .

#build the docker image to Prod Repo
echo " Building Docker Image..."
docker build -t $PROD_IMAGE_NAME:$PROD_TAG .


#push both tags to Docker hub
echo "pushing dev tag..."
docker push $DEV_IMAGE_NAME:$DEV_TAG

echo "Pushing prod tag.."
docker push $PROD_IMAGE_NAME:$PROD_TAG

echo " Done"





