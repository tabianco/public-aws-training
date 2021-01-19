#!/bin/bash

set -eux

cd $(dirname "$0")

TEMPLATE="ecs.yml"
STACK_NAME="ecs"

aws cloudformation deploy --stack-name ${STACK_NAME} --template-file ${TEMPLATE} --capabilities CAPABILITY_NAMED_IAM