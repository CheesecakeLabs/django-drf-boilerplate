#!/bin/bash
set -e
set -u

AWS_RESOURCE_NAME=""
case $1 in
    "master")
        AWS_RESOURCE_NAME="${AWS_RESOURCE_NAME_PREFIX}/production"
    ;;
    "staging")
        AWS_RESOURCE_NAME="${AWS_RESOURCE_NAME_PREFIX}/staging"
    ;;
    "lab")
        AWS_RESOURCE_NAME="${AWS_RESOURCE_NAME_PREFIX}/lab"
    ;;
    *)
        echo "branch not defined"
        exit 1
    ;;
esac

echo "release ${CIRCLE_BRANCH}"
docker tag ${IMAGE_NAME}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME}:latest
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME}:latest