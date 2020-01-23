FROM ideavate/amazonlinux-node:12-serverless

# This should be where the base image installed the serverless tools
# Note that the workdir appears to be overridden by the GitHub Actions runtime
WORKDIR /serverless

COPY *.sh /serverless/

ENTRYPOINT ["/serverless/entrypoint.sh"]