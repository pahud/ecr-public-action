#!/bin/sh -l

CONTEXT=${INPUT_CONTEXT-.}
[ -z $CONTEXT ] && CONTEXT='.'

DOCKERFILE=${INPUT_DOCKERFILE-Dockerfile}
[ -z $DOCKERFILE ] && DOCKERFILE='Dockerfile'

echo $INPUT_CREATE_REPO
CREATE_REPO=${INPUT_CREATE_REPO-false}
[ -z $CREATE_REPO ] && CREATE_REPO='false'

echo $CREATE_REPO
echo "check repo exist or not"
REPO=$CREATE_REPO
if [ $CREATE_REPO != false ]; then
        aws ecr-public describe-repositories --region us-east-1 --repository-names $REPO || aws ecr-public create-repository --repository-name $REPO
fi

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
