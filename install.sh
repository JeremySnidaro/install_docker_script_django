#!/bin/bash

# Install & enable Docker
amazon-linux-extras install docker -y
systemctl enable docker.service
service docker start
usermod -a -G docker ec2-user

# Install Docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

yum install -y git
git clone https://gitlab.com/andreacarrieroo/devops-technical-test /opt/devops-technical-test

# Replace listening Ip and Allowed host to enable access to the website
sed -i "s/127.0.0.1/0.0.0.0/g" /opt/devops-technical-test/Dockerfile
sed -i "s/*/example.com/g" /opt/devops-technical-test/django_project/django_project/settings.py

cd /opt/devops-technical-test && docker-compose up -d
