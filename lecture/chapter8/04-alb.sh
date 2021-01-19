#!/bin/bash

set -eux

cd $(dirname "$0")

TEMPLATE="alb.yml"
STACK_NAME="alb"

aws cloudformation deploy --stack-name ${STACK_NAME} --template-file ${TEMPLATE}