FROM ideavate/amazonlinux-node:12-serverless

# This should be where the base image installed the serverless tools
# Note that the workdir appears to be overridden by the GitHub Actions runtime
WORKDIR /serverless

COPY entrypoint.sh .
COPY setup_aws_profile.sh .
COPY setup_npm_profile.sh .
COPY deploy_to_lambda.sh .
COPY JSON.sh .

ENTRYPOINT ["/serverless/entrypoint.sh"]