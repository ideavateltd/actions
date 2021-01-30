#!/bin/sh

VERSION=$1
ENVIRONMENT=$2

if [[ "$NPM_PACKAGE" != "" ]]; then
  if [[ "$NPM_URL" != "" ]]; then
    ./setup_npm_profile.sh
  fi

  echo "Fetching ${NPM_PACKAGE}@${VERSION} from npm"
  npm pack ${NPM_PACKAGE}@${VERSION}

  echo "Re-packing artifact"
  tar zxf *.tgz
  cd package
  zip package.zip . -rq
elif [[ "$MVN_GROUPID" != "" ]]; then
  GROUP_PATH=`echo ${MVN_GROUPID} | sed "s,\.,/,g"`

  if [[ "${VERSION}" == "latest" || "${VERSION}" == "release" ]]; then
    META_URL="${MVN_REPO}/${GROUP_PATH}/${MVN_ARTIFACTID}/maven-metadata.xml"
    echo "Fetching metadata from ${META_URL} to resolve ${VERSION}"
    RESOLVED_VERSION=`curl -\# -f -u "${MVN_USERNAME}:${MVN_PASSWORD}" "${META_URL}" | tr '\n' ' ' | sed -E "s,.*<${VERSION}>(.*)</${VERSION}>.*,\1,"`
    echo "${VERSION} version was ${RESOLVED_VERSION}"
    VERSION=${RESOLVED_VERSION}
  fi

  ARTIFACT_URL="${MVN_REPO}/${GROUP_PATH}/${MVN_ARTIFACTID}/${VERSION}/${MVN_ARTIFACTID}-${VERSION}-lambda.zip"
  echo "Fetching ${ARTIFACT_URL}"
  curl -# -f -u "${MVN_USERNAME}:${MVN_PASSWORD}" -o package.zip "${ARTIFACT_URL}"
  unzip package.zip serverless.yml
fi

echo "Starting deployment to ${ENVIRONMENT}"
serverless deploy -s ${ENVIRONMENT}
