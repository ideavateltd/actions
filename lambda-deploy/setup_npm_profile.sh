#!/bin/sh
#
# Setup NPM environment

if [[ "$NPM_URL" != "" ]]; then
  # AWS CodeArtifact auth
  if [[ "$NPM_TOKEN" == "" && $(expr match "$NPM_URL" ".*codeartifact\..*amazonaws\.com") != 0 ]]; then
    # Create aws codeartifact get-authorization-token command to issue token
    npmLogin=`echo "$NPM_URL" | sed -E 's,^https://([a-z]+)-([0-9]+)\.d\.codeartifact\.([a-z][a-z]-[a-z]+-[0-9]+)\.amazonaws.com/npm/([a-z]+)/$,aws codeartifact get-authorization-token --domain \1 --domain-owner \2 --region \3 --query authorizationToken --output text,'`
    echo "Calling ${npmLogin}"
    NPM_TOKEN=`${npmLogin} | tr -d '[:space:]'`
  fi
  if [[ "$NPM_TOKEN" != "" ]]; then
    npm set registry ${NPM_URL} --always-auth
    AUTH_URL=`echo ${NPM_URL} | sed "s,.*://,//,"`
    npm set "${AUTH_URL}:_authToken" "${NPM_TOKEN}"
  else
    npm set registry ${NPM_URL}
  fi;
fi