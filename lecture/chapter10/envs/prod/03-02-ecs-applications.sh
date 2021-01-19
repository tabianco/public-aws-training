#!/bin/bash

set -eux

cd $(dirname "$0")

# 本番環境
ENV="prod"

ClusterName="app-cluster-prod"
VPCId="vpc-xxxxxxxx"
# VPCのインターナルの通信を許可するSG
ECSSecurityGroupIds="sg-xxxxxxxx"
# VPCのインターナルの通信を許可するSGと、外部のHTTP,HTTPS(web)の通信を許可するSG
ALBSecurityGroupIds="sg-xxxxxxxx, sg-yyyyyyyy"
# プライベートサブネットのIDs
ECSSubnetIds="subnet-xxxxxxxx, subnet-yyyyyyyy"
# パブリックサブネットのIDs
ALBSubnetIds="subnet-xxxxxxxx, subnet-yyyyyyyy"


# packageコマンド、テンプレートをS3にアップロードする
aws cloudformation package \
    --template-file "../../modules/ecs/applications/app-A/main.yml" \
    --s3-bucket xxxx-xxxx-bucket \
    --output-template-file ./tmp/ecs-app-A.yml


# app-Aをデプロイ
aws cloudformation deploy \
  --template-file "./tmp/ecs-app-A.yml" \
  --stack-name "ecs-app-A-${ENV}" \
  --parameter-overrides \
    ENV=$ENV \
    ClusterName=$ClusterName \
    VPCId=$VPCId \
    ECSSecurityGroupIds="$ECSSecurityGroupIds" \
    ALBSecurityGroupIds="$ALBSecurityGroupIds" \
    ECSSubnetIds="$ECSSubnetIds" \
    ALBSubnetIds="$ALBSubnetIds" \
  --capabilities CAPABILITY_NAMED_IAM


# packageコマンド、テンプレートをS3にアップロードする
aws cloudformation package \
    --template-file "../../modules/ecs/applications/app-B/main.yml" \
    --s3-bucket aws-training-cfn-module-stack \
    --output-template-file ./tmp/ecs-app-B.yml


# app-Bをデプロイ
aws cloudformation deploy \
  --template-file "./tmp/ecs-app-B.yml" \
  --stack-name "ecs-app-B-${ENV}" \
  --parameter-overrides \
    ENV=$ENV \
    ClusterName=$ClusterName \
    VPCId=$VPCId \
    ECSSecurityGroupIds="$ECSSecurityGroupIds" \
    ALBSecurityGroupIds="$ALBSecurityGroupIds" \
    ECSSubnetIds="$ECSSubnetIds" \
    ALBSubnetIds="$ALBSubnetIds" \
  --capabilities CAPABILITY_NAMED_IAM
