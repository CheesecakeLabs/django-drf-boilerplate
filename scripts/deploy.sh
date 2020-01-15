  
#!/bin/bash
set -e
set -u

case $1 in
    'staging')
        echo "deploying to STAGING"
        ecs-deploy -c ${AWS_CLUSTER_NAME} -n ${AWS_SERVICE_NAME} -i ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME_PREFIX_STAGING}:${CIRCLE_SHA1} -r ${AWS_DEFAULT_REGION}
    ;;
    *)
        echo "deploying to PRODUCTION"
        ecs-deploy -c ${AWS_CLUSTER_NAME} -n ${AWS_SERVICE_NAME} -i ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME_PREFIX_PROD}:${CIRCLE_SHA1} -r ${AWS_DEFAULT_REGION}
    ;;
esac