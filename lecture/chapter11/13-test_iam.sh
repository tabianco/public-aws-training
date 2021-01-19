#!/bin/bash

set -eux

cd $(dirname "$0")

TEMPLATE="test_iam.yml"
STACK_NAME="test-iam"

aws cloudformation deploy --stack-name ${STACK_NAME} --template-file ${TEMPLATE} --capabilities CAPABILITY_NAMED_IAM