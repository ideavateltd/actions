#!/bin/sh
#
# Setup NPM environment

if [[ "$NPM_URL" != "" ]]; then
  if [[ "$NPM_TOKEN" != "" ]]; then
    npm set registry ${NPM_URL} --always-auth
    npm set '//${NPM_URL}:_authToken' '${NPM_TOKEN}'
  else
    npm set registry 'https://${NPM_URL}'
  fi;
fi