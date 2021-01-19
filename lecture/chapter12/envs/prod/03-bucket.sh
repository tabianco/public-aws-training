#!/bin/bash

set -eux

cd $(dirname "$0")

# 本番環境
ENV="prod"

# 共通化されたテンプレートを指定する
TEMPLATE="../../modules/s3/buckets.yml"
STACK_NAME="s3-buckets-${ENV}"

aws cloudformation deploy \
  --stack-name ${STACK_NAME} \
  --template-file ${TEMPLATE} \
  --parameter-overrides \
    ENV=$ENV \
    Name="aws-training"
