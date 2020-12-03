#!/bin/sh -l


echo "TAG_LATEST=${TAG_LATEST}"

aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws

docker build -t ${TAG_LATEST} .
docker push ${TAG_LATEST}

# docker tag busybox:latest public.ecr.aws/d7p2r8s3/busybox:latest

# docker push public.ecr.aws/d7p2r8s3/busybox:latest

# npx cdk $@
# echo "::set-output name=output::$output"
