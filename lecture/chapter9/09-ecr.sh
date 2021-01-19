#!/bin/bash

set -eux

cd $(dirname "$0")

TEMPLATE="ecr.yml"
STACK_NAME="ecr"

aws cloudformation deploy --stack-name ${STACK_NAME} --template-file ${TEMPLATE}