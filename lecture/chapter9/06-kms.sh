#!/bin/bash

set -eux

cd $(dirname "$0")

TEMPLATE="kms.yml"
STACK_NAME="kms"

aws cloudformation deploy --stack-name ${STACK_NAME} --template-file ${TEMPLATE}