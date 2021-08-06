#!/bin/bash

INSTANCE_ID=$1
PROFILE=$2

aws ssm send-command \
    --document-name "AWS-ConfigureAWSPackage" \
    --instance-ids "$INSTANCE_ID" \
    --parameters '{"action":["Install"],"installationType":["Uninstall and reinstall"],"name":["AWSCodeDeployAgent"]}' \
    --profile "$PROFILE"
