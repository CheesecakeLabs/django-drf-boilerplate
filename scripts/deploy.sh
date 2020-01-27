  
#!/bin/bash
set -e
set -u

case $1 in
    'staging')
        echo "deploying to STAGING"
        ecs-deploy -c ${AWS_CLUSTER_NAME} -n ${AWS_SERVICE_NAME_STAGING} -i ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME_PREFIX_STAGING}:${CIRCLE_SHA1} -r ${AWS_DEFAULT_REGION} --timeout 108000
    ;;
    *)
        echo "deploying to PRODUCTION"
        ecs-deploy -c ${AWS_CLUSTER_NAME} -n ${AWS_SERVICE_NAME_PROD} -i ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME_PREFIX}:${CIRCLE_SHA1} -r ${AWS_DEFAULT_REGION} --timeout 108000
    ;;
esac