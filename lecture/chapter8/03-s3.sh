#!/bin/bash

set -eux

cd $(dirname "$0")

TEMPLATE="s3.yml"
STACK_NAME="s3"

aws cloudformation deploy \
--stack-name ${STACK_NAME} \
--template-file ${TEMPLATE}