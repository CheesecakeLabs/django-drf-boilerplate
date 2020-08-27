#!/bin/bash
set -e
set -u

SERVICE_NAME=""
AWS_CLUSTER_NAME=""
AWS_RESOURCE_NAME=""
TAG=""
case $1 in
    "lab")
        echo "deploying to LAB"
        SERVICE_NAME=${AWS_SERVICE_NAME_LAB}
        AWS_CLUSTER_NAME=${AWS_CLUSTER_NAME_LAB}
        AWS_RESOURCE_NAME="${AWS_RESOURCE_NAME_PREFIX}/lab"
        TAG="latest"
    ;;
    "staging")
        echo "deploying to STAGING"
        SERVICE_NAME=${AWS_SERVICE_NAME_STAGING}
        AWS_CLUSTER_NAME=${AWS_CLUSTER_NAME_STAGING}
        AWS_RESOURCE_NAME="${AWS_RESOURCE_NAME_PREFIX}/staging"
        TAG="latest"
    ;;
    *)
        echo "deploying to PRODUCTION"
        SERVICE_NAME=${AWS_SERVICE_NAME_PROD}
        AWS_CLUSTER_NAME=${AWS_CLUSTER_NAME_PROD}
        AWS_RESOURCE_NAME="${AWS_RESOURCE_NAME_PREFIX}/production"
        TAG=${CIRCLE_TAG}
        docker tag ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME}:${CIRCLE_TAG}
        docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME}:${CIRCLE_TAG}
    ;;
esac

# deploying to AWS ECS
ecs-deploy -c ${AWS_CLUSTER_NAME} -n ${SERVICE_NAME} -i ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME}:${TAG} -r ${AWS_DEFAULT_REGION} --timeout 108000
