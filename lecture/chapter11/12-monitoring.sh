#!/bin/bash

set -eux

cd $(dirname "$0")

TEMPLATE="monitoring.yml"
STACK_NAME="monitoring"

aws cloudformation deploy --stack-name ${STACK_NAME} --template-file ${TEMPLATE} --capabilities CAPABILITY_NAMED_IAM