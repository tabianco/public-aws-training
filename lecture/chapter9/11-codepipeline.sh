#!/bin/bash

set -eux

cd $(dirname "$0")

TEMPLATE="codepipeline.yml"
STACK_NAME="codepipeline"

aws cloudformation deploy \
--stack-name ${STACK_NAME} \
--template-file ${TEMPLATE} \
--capabilities CAPABILITY_NAMED_IAM