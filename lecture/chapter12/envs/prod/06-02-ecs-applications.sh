#!/bin/bash

set -eux

cd $(dirname "$0")

# 本番環境
ENV="prod"

ClusterName="app-cluster-prod"
VPCId="vpc-xxxxxxxx"
# VPCのインターナルの通信を許可するSG
ECSSecurityGroupIds="sg-xxxxxxxx, sg-yyyyyyyy"
# VPCのインターナルの通信を許可するSGと、外部のHTTP,HTTPS(web)の通信を許可するSG
ALBSecurityGroupIds="sg-xxxxxxxx, sg-yyyyyyyy"
# プライベートサブネットのIDs
ECSSubnetIds="subnet-xxxxxxxx, subnet-yyyyyyyy"
# パブリックサブネットのIDs
ALBSubnetIds="subnet-xxxxxxxx, subnet-yyyyyyyy"
# ALBのログを保存するバケット
ALBLogBucketName="alb-log-aws-training-prod"

BucketName="connection-test-aws-training-prod"
DBHost="xxxxxxxx.us-east-1.rds.amazonaws.com"
RedisHost="xxxxxxxx.cache.amazonaws.com"


# packageコマンド、テンプレートをS3にアップロードする
aws cloudformation package \
    --template-file "../../modules/ecs/applications/practical-problem-app/main.yml" \
    --s3-bucket aws-training-cfn-module-stack \
    --output-template-file ./tmp/practical-problem-app.yml


# デプロイ
aws cloudformation deploy \
  --template-file "./tmp/practical-problem-app.yml" \
  --stack-name "practical-problem-app-${ENV}" \
  --parameter-overrides \
    ENV=$ENV \
    ClusterName=$ClusterName \
    VPCId=$VPCId \
    ECSSecurityGroupIds="$ECSSecurityGroupIds" \
    ALBSecurityGroupIds="$ALBSecurityGroupIds" \
    ECSSubnetIds="$ECSSubnetIds" \
    ALBSubnetIds="$ALBSubnetIds" \
    ALBLogBucketName="$ALBLogBucketName" \
    BucketName="$BucketName" \
    DBHost="$DBHost" \
    RedisHost="$RedisHost" \
  --capabilities CAPABILITY_NAMED_IAM
