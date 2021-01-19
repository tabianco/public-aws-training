#!/bin/bash

set -eux

cd $(dirname "$0")

TEMPLATE="db.yml"
STACK_NAME="db"

aws cloudformation deploy --stack-name ${STACK_NAME} --template-file ${TEMPLATE}