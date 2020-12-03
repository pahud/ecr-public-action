#!/bin/sh -l

# echo "TAG_LATEST=${TAG_LATEST}"
TAGS=($(echo $INPUT_TAGS | tr "\n" " "))

aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws

docker build -t tmp .

for t in ${TAGS}
do
  docker tag tmp $t
  docker push $t
done


# docker tag busybox:latest public.ecr.aws/d7p2r8s3/busybox:latest

# docker push public.ecr.aws/d7p2r8s3/busybox:latest

# npx cdk $@
# echo "::set-output name=output::$output"
