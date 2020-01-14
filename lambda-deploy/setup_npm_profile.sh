#!/bin/sh
#
# Setup NPM environment

if [[ "$NPM_URL" != "" ]]; then
  if [[ "$NPM_TOKEN" != "" ]]; then
    npm set registry ${NPM_URL} --always-auth
    AUTH_URL=`echo ${NPM_URL} | sed "s,.*://,//,"`
    npm set '${AUTH_URL}:_authToken' '${NPM_TOKEN}'
  else
    npm set registry ${NPM_URL}
  fi;
fi