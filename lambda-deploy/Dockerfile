FROM node:12-alpine

RUN apk --no-cache add zip

# This should be where the base image installed the serverless tools
# Note that the workdir appears to be overridden by the GitHub Actions runtime
WORKDIR /serverless

COPY package.json package-lock.json /serverless/
RUN npm ci

ENV PATH="/serverless/node_modules/.bin:${PATH}"

COPY *.sh /serverless/

ENTRYPOINT ["/serverless/entrypoint.sh"]