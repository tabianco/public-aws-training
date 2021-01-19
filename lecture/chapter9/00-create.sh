#!/bin/bash

set -eux

cd $(dirname "$0")

echo "-- vpc";
aws cloudformation deploy --stack-name vpc --template-file vpc.yml

echo "-- iam";
aws cloudformation deploy --stack-name iam --template-file iam.yml --capabilities CAPABILITY_NAMED_IAM

echo "-- s3";
aws cloudformation deploy --stack-name s3 --template-file s3.yml

echo "-- acm";
aws cloudformation deploy --stack-name acm --template-file acm.yml

echo "-- alb";
aws cloudformation deploy --stack-name alb --template-file alb.yml

echo "-- dns";
aws cloudformation deploy --stack-name dns --template-file dns.yml

echo "-- ecs"
aws cloudformation deploy --stack-name ecs --template-file ecs.yml --capabilities CAPABILITY_NAMED_IAM

echo "-- kms"
aws cloudformation deploy --stack-name kms --template-file kms.yml

echo "-- ssm"
aws cloudformation deploy --stack-name ssm --template-file ssm.yml

echo "-- db"
aws cloudformation deploy --stack-name db --template-file db.yml

# echo "-- ecr"
# aws cloudformation deploy --stack-name ecr --template-file ecr.yml

# echo "-- codebuild"
# aws cloudformation deploy --stack-name codebuild --template-file codebuild.yml --capabilities CAPABILITY_NAMED_IAM

# echo "-- codepipeline"
# aws cloudformation deploy --stack-name codepipeline --template-file codepipeline.yml --capabilities CAPABILITY_NAMED_IAM