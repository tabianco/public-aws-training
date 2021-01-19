#!/bin/bash

set -eux

cd $(dirname "$0")

# 本番環境
ENV="prod"

# 共通化されたテンプレートを指定する
TEMPLATE="../../modules/database/elasticache.yml"
STACK_NAME="elasticache-${ENV}"

# `--parameter-overrides` でテンプレートのParametersの値を指定できる
# テンプレート側で環境(prod, stg, dev)によって違う値を入れられるようにしましょう
aws cloudformation deploy \
  --stack-name ${STACK_NAME} \
  --template-file ${TEMPLATE} \
  --parameter-overrides \
    ENV=$ENV \
    Name="aws-training" \
    RedisSubnetGroupIds="subnet-xxxxxxxx, subnet-yyyyyyyy" \
    RedisSecurityGroupIds="sg-xxxxxxxx" \
    RedisInstanceClass="cache.t3.micro"
