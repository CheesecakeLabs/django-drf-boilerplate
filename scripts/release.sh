  
#!/bin/bash
set -e
set -u

case $1 in
    'staging')
        echo "releasing to STAGING"
        docker tag ${IMAGE_NAME}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME_PREFIX_STAGING}:${CIRCLE_SHA1}
        docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME_PREFIX_STAGING}:${CIRCLE_SHA1}
    ;;
    'master')
        echo "release to PRODUCTION"
        docker tag ${IMAGE_NAME}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME_PREFIX_PROD}:${CIRCLE_SHA1}
        docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME_PREFIX_PROD}:${CIRCLE_SHA1}
    ;;
    *)
        echo "release not defined"
        exit 1
    ;;
esac