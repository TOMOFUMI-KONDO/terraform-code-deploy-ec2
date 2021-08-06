#!/bin/bash

PROJECT=$1
REPOSITORY=$2
COMMIT=$3
PROFILE=$4

aws deploy create-deployment \
    --application-name "$PROJECT"-code-deploy-app \
    --deployment-config-name CodeDeployDefault.OneAtATime \
    --deployment-group-name "$PROJECT"-code-deploy-group \
    --description "deployment for terraform sandbox" \
    --github-location repository="$REPOSITORY",commitId="$COMMIT" \
    --profile "$PROFILE"
