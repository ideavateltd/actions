#!/bin/sh

VERSION=$1
ENVIRONMENT=$2

echo "Fetching ${NPM_PACKAGE}@${VERSION} from npm"
npm pack ${NPM_PACKAGE}@${VERSION}

echo "Re-packing artifact"
tar zxf *.tgz
cd package
zip package.zip . -rq

echo "Starting deployment to ${ENVIRONMENT}"
serverless deploy -s ${ENVIRONMENT}
