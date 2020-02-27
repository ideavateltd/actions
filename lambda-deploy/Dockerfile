FROM node:12-alpine

RUN apk --no-cache add zip

# This should be where the base image installed the serverless tools
# Note that the workdir appears to be overridden by the GitHub Actions runtime
WORKDIR /serverless

RUN npm install \
  serverless \
  serverless-offline \
  serverless-prune-plugin \
  serverless-plugin-warmup \
  serverless-domain-manager \
  serverless-apigw-binary \
  serverless-content-encoding \
  serverless-plugin-include-dependencies \
  serverless-finch \
  serverless-dynamodb-autoscaling \
  serverless-dynamodb-local \
  serverless-plugin-additional-stacks \
  serverless-plugin-log-retention

ENV PATH="/serverless/node_modules/.bin:${PATH}"

COPY *.sh /serverless/

ENTRYPOINT ["/serverless/entrypoint.sh"]