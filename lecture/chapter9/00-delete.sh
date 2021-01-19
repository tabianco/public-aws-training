#!/bin/bash

set -eux

cd $(dirname "$0")

echo "-- codepipeline";
aws s3 rm s3://artifact-bucket-of-aws-training --recursive
aws cloudformation delete-stack --stack-name codepipeline
aws cloudformation wait stack-delete-complete --stack-name codepipeline

echo "-- codebuild";
aws cloudformation delete-stack --stack-name codebuild
aws cloudformation wait stack-delete-complete --stack-name codebuild

echo "-- ecr";
IMAGES=$(aws ecr list-images --repository-name aws-training --query 'imageIds[*]' --output json)
if [ $IMAGES == '[]' ]; then
    echo "ecr is empty";
else
    aws ecr batch-delete-image --repository-name aws-training --image-ids "$IMAGES"
fi
aws cloudformation delete-stack --stack-name ecr
aws cloudformation wait stack-delete-complete --stack-name ecr

echo "-- db";
aws rds modify-db-instance --db-instance-identifier awsTrainingRds --no-deletion-protection --apply-immediately
aws cloudformation delete-stack --stack-name db
aws cloudformation wait stack-delete-complete --stack-name db

echo "-- ssm";
aws cloudformation delete-stack --stack-name ssm
aws cloudformation wait stack-delete-complete --stack-name ssm

echo "-- kms";
aws cloudformation delete-stack --stack-name kms
aws cloudformation wait stack-delete-complete --stack-name kms

echo "-- ecs";
aws cloudformation delete-stack --stack-name ecs
aws cloudformation wait stack-delete-complete --stack-name ecs

echo "-- dns";
aws cloudformation delete-stack --stack-name dns
aws cloudformation wait stack-delete-complete --stack-name dns

echo "-- alb";
aws cloudformation delete-stack --stack-name alb
aws cloudformation wait stack-delete-complete --stack-name alb

echo "-- acm";
aws cloudformation delete-stack --stack-name acm
aws cloudformation wait stack-delete-complete --stack-name acm

echo "-- s3";
aws s3 rm s3://s3-private-bucket-of-aws-training --recursive
aws s3 rm s3://s3-public-bucket-of-aws-training --recursive
aws s3 rm s3://s3-alb-log-bucket-of-aws-training --recursive
aws cloudformation delete-stack --stack-name s3
aws cloudformation wait stack-delete-complete --stack-name s3

echo "-- iam";
aws cloudformation delete-stack --stack-name iam
aws cloudformation wait stack-delete-complete --stack-name iam

echo "-- vpc";
aws cloudformation delete-stack --stack-name vpc
aws cloudformation wait stack-delete-complete --stack-name vpc
