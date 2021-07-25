#!/bin/bash

#install python3 & pip
apt-get update
apt-get install -y python3-pip

#remove installed docker
apt-get remove docker docker-engine docker.io containerd runc

#install docker
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce=5:19.03.5~3-0~ubuntu-bionic
usermod -aG docker ubuntu

su - ubuntu
export LANGUAGE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

#install awscli
pip3 install awscli --upgrade --user
export PATH=~/.local/bin:$PATH

#login to ecr
$(aws ecr get-login --no-include-email --region ${aws_region})

#using printf to add contents of ssh key to file, since echo doesnt preserved line-endings
#https://unix.stackexchange.com/questions/65803/why-is-printf-better-than-echo
#https://stackoverflow.com/questions/11618696/shell-write-variable-contents-to-a-file
printf "%s" "${ssh_private_key}" > /tmp/key

#run jenkins docker container
docker run -d -p 8080:8080 \
    -e JENKINS_PASSWORD=${admin_password} \
    -e JENKINS_READ_ONLY_PASSWORD=${readonly_password} \
    -e GITHUB_USER_NAME=${github_user_name} \
    -v /tmp/key:/run/secrets/SSH_PRIVATE_KEY \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --name jenkins \
    038062473746.dkr.ecr.us-east-1.amazonaws.com/bootcamp-2021-ee-pune-ecr/jenkins:${image_tag}