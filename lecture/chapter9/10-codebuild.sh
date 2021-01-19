#!/bin/bash

set -eux

cd $(dirname "$0")

TEMPLATE="codebuild.yml"
STACK_NAME="codebuild"

aws cloudformation deploy --stack-name ${STACK_NAME} --template-file ${TEMPLATE} --capabilities CAPABILITY_NAMED_IAM