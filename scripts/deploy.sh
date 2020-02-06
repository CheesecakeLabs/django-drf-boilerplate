  
#!/bin/bash
set -e
set -u

SERVICE_NAME=""
TAG=""
case $1 in
    "lab")
        echo "deploying to LAB"
        SERVICE_NAME=${AWS_SERVICE_NAME_LAB}
        TAG="lab"
    ;;
    "staging")
        echo "deploying to STAGING"
        SERVICE_NAME=${AWS_SERVICE_NAME_STAGING}
        TAG="staging"
    ;;
    *)
        echo "deploying to PRODUCTION"
        SERVICE_NAME=${AWS_SERVICE_NAME_PROD}
        TAG=${CIRCLE_TAG}
        docker tag ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME_PREFIX}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME_PREFIX}:${CIRCLE_TAG}
        docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME_PREFIX}:${CIRCLE_TAG}
    ;;
esac

# deploying to AWS ECS
ecs-deploy -c ${AWS_CLUSTER_NAME} -n ${SERVICE_NAME} -i ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME_PREFIX}:${TAG} -r ${AWS_DEFAULT_REGION} --timeout 108000