#!/bin/bash

set -eux

cd $(dirname "$0")

TEMPLATE="ssm.yml"
STACK_NAME="ssm"

aws cloudformation deploy --stack-name ${STACK_NAME} --template-file ${TEMPLATE}