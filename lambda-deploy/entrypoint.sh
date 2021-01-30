#!/bin/sh

BASEDIR=$(dirname $0)
VERSION=$1
ENVIRONMENT=$2

cd ${BASEDIR}

echo GITHUB_REF=$GITHUB_REF

if [[ "$VERSION" == "" ]]; then
  # Extract environment from deployment event
  ENVIRONMENT=`cat $GITHUB_EVENT_PATH | ./JSON.sh | grep '\["deployment","environment"]' | cut -f2 | sed -e 's/"//g'`
  # Extract version from GITHUB_REF
  if [[ "$GITHUB_REF" == "refs/heads/main" || "$GITHUB_REF" == "refs/heads/master" || "$GITHUB_REF" == "" ]]; then
    VERSION="latest"
  else
    # Process GitHub ref to get version:
    # 1. tag ref prefix
    # 2. npm package name prefix and @ if present
    VERSION=`echo $GITHUB_REF | sed s,refs/tags/,,  | sed s,${NPM_PACKAGE}@,,`
  fi
fi

./setup_aws_profile.sh

echo "Received deployment request for ${NPM_PACKAGE}${MVN_ARTIFACTID} @ ${VERSION} to ${ENVIRONMENT}"

if [[ "$ENVIRONMENT" == "live" ]]; then
  if [[ "$VERSION" == "latest" ]] && [[ "$ALLOW_LATEST_ON_LIVE" != "true" ]]; then
    echo "ERROR: You are only allowed to deploy a tagged version to the live environment"
    exit 1
  fi
  ./deploy_to_lambda.sh $VERSION live
elif [[ "$ENVIRONMENT" == "staging" ]]; then
  ./deploy_to_lambda.sh $VERSION staging
else
  echo "ERROR: Unknown environment: ${ENVIRONMENT}"
  exit 1
fi

RESULT=$?
MSG=$*

if [ 0 != "${RESULT}" ]; then
  echo "ERROR: Failed '${MSG}'! Exit code '${RESULT}' is not equal to 0"
  echo "${MSG}"
  exit ${RESULT}
fi

echo "${MSG}"
exit 0