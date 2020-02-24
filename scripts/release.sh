  
#!/bin/bash
set -e
set -u

TAG=""
case $1 in
    "master")
        TAG="latest"
    ;;
    "staging")
        TAG="staging"
    ;;
    "lab")
        TAG="lab"
    ;;
    *)
        echo "branch not defined"
        exit 1
    ;;
esac
echo "release ${CIRCLE_BRANCH}"
docker tag ${IMAGE_NAME}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME_PREFIX}:${TAG}
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME_PREFIX}:${TAG}