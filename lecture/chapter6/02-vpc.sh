#!/bin/bash

set -eux

cd $(dirname "$0")

TEMPLATE="vpc.yml"
STACK_NAME="vpc"

aws cloudformation deploy \
--stack-name ${STACK_NAME} \
--template-file ${TEMPLATE}