#!/bin/bash

set -eux

cd $(dirname "$0")

# 本番環境
ENV="prod"

# 共通化されたテンプレートを指定する
TEMPLATE="../../modules/database/rds.yml"
STACK_NAME="rds-${ENV}"

# `--parameter-overrides` でテンプレートのParametersの値を指定できる
# テンプレート側で環境(prod, stg, dev)によって違う値を入れられるようにしましょう
aws cloudformation deploy \
  --stack-name ${STACK_NAME} \
  --template-file ${TEMPLATE} \
  --parameter-overrides \
    ENV=$ENV \
    DBInstanceName="aws-training" \
    RdsSubnetGroupIds="subnet-xxxxxxxx, subnet-yyyyyyyy" \
    RdsSecurityGroupIds="sg-xxxxxxxx" \
    DBInstanceClass="db.t3.micro"
