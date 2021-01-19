#!/bin/bash

set -eux

cd $(dirname "$0")

# 本番環境
ENV="prod"

# 共通化されたテンプレートを指定する
TEMPLATE="../../modules/network/common-security-groups.yml"
STACK_NAME="common-security-groups-${ENV}"

aws cloudformation deploy \
  --stack-name ${STACK_NAME} \
  --template-file ${TEMPLATE} \
  --parameter-overrides \
    ENV=$ENV \
    VPCId="vpc-xxxxxxxx"
