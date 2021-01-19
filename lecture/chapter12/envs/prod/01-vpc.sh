#!/bin/bash

set -eux

cd $(dirname "$0")

# 本番環境
ENV="prod"

# 共通化されたテンプレートを指定する
TEMPLATE="../../modules/network/vpc.yml"
STACK_NAME="vpc-${ENV}"

# `--parameter-overrides` でテンプレートのParametersの値を指定できる
# テンプレート側で環境(prod, stg, dev)によって違う値を入れられるようにしましょう
aws cloudformation deploy \
  --stack-name ${STACK_NAME} \
  --template-file ${TEMPLATE} \
  --parameter-overrides \
    ENV=$ENV \
    VPCName="aws-training" \
    VPCCidrBlock="10.0.0.0/16" \
    PublicSubnet1aCidrBlock="10.0.1.0/24" \
    PublicSubnet1cCidrBlock="10.0.2.0/24" \
    PrivateSubnet1aCidrBlock="10.0.65.0/24" \
    PrivateSubnet1cCidrBlock="10.0.66.0/24"
