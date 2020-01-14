#!/bin/sh
#
# Setup AWS environment

# Respect AWS_DEFAULT_REGION if specified
[ -n "$AWS_DEFAULT_REGION" ] || export AWS_DEFAULT_REGION=eu-west-1

# Respect AWS_DEFAULT_OUTPUT if specified
[ -n "$AWS_DEFAULT_OUTPUT" ] || export AWS_DEFAULT_OUTPUT=json

# Respect AWS_PROFILE if specific
[ -n "$AWS_PROFILE" ] || export AWS_PROFILE=deploy

AWS_CONFIG_FILE=${HOME}/.aws/config
AWS_CREDENTIALS_FILE=${HOME}/.aws/credentials

# Set up eb profile
mkdir ${HOME}/.aws
touch $AWS_CONFIG_FILE
touch $AWS_CREDENTIALS_FILE
chmod 600 $AWS_CONFIG_FILE
chmod 600 $AWS_CREDENTIALS_FILE

cat << EOF > $AWS_CONFIG_FILE
[profile ${AWS_PROFILE}]
output = ${AWS_DEFAULT_OUTPUT}
region = ${AWS_DEFAULT_REGION}
EOF

cat << EOF > $AWS_CREDENTIALS_FILE
[${AWS_PROFILE}]
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}
EOF