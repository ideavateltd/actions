FROM node:12-alpine

RUN apk --no-cache add zip curl python
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
RUN unzip awscli-bundle.zip
RUN ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

# This should be where the base image installed the serverless tools
# Note that the workdir appears to be overridden by the GitHub Actions runtime
WORKDIR /serverless

COPY package.json package-lock.json /serverless/
RUN npm ci

ENV PATH="/serverless/node_modules/.bin:${PATH}"

COPY *.sh /serverless/

ENTRYPOINT ["/serverless/entrypoint.sh"]