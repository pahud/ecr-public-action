FROM public.ecr.aws/amazonlinux/amazonlinux:2023

RUN dnf install docker -y

# install aws-cli v2
RUN yum install -y awscli

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
