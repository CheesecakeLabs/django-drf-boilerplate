  
#!/bin/bash
set -e
set -u

case $1 in
    *)
        echo "release ${CIRCLECI_BRANCH}"
        docker tag ${IMAGE_NAME}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME_PREFIX}:${CIRCLE_SHA1}
        docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${AWS_RESOURCE_NAME_PREFIX}:${CIRCLE_SHA1}
    ;;
esac