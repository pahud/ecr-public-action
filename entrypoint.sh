#!/bin/sh -l

CONTEXT=${INPUT_CONTEXT-.}
[ -z $CONTEXT ] && CONTEXT='.'

DOCKERFILE=${INPUT_DOCKERFILE-Dockerfile}
[ -z $DOCKERFILE ] && DOCKERFILE='Dockerfile'

echo "INPUT_TAGS=${INPUT_TAGS}"
TAGS=$(echo $INPUT_TAGS | tr "\n" " ")
echo "found TAGS=$TAGS"

aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws

echo "docker build -t tmp -f ${DOCKERFILE} ${CONTEXT}"

docker build -t tmp -f ${DOCKERFILE} ${CONTEXT}

for t in ${TAGS}
do
  echo "docker tag tmp $t"
  docker tag tmp $t
  echo "docker push $t"
  docker push $t
done


# docker tag busybox:latest public.ecr.aws/d7p2r8s3/busybox:latest

# docker push public.ecr.aws/d7p2r8s3/busybox:latest

# npx cdk $@
# echo "::set-output name=output::$output"
