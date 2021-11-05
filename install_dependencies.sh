#!/bin/bash
sudo yum update -y
sudo yum install yum-utils git -y 

sudo yum install docker -y
sudo usermod -aG docker ec2-user
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


# start services
sudo systemctl enable docker
sudo systemctl start docker

# Estrutura de Pastas para o Jenkins
mkdir -p /home/ec2-user/jenkins-data/jenkins_home
sudo chown ec2-user: /home/ec2-user/* -R 

# Baixando imagem do Jenkins
docker pull jenkins/jenkins

# #Setting permissions
# sudo chown ec2-user: /var/run/docker.sock

# #Creating dockerfile
# cat <<EOF > /home/ec2-user/jenkins-data/Dockerfile
# FROM jenkins/jenkins
# USER root

# # Install Pip
# RUN apt-get update && apt-get install python3-pip -y && \
#     pip3 install ansible --upgrade

# # Install Docker
# RUN apt-get update && \
#     apt-get -y install apt-transport-https ca-certificates wget curl gnupg2 software-properties-common && \
#     curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
#     add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" && \
#     apt-get update && \
#     apt-get -y install docker-ce

# # Install Docker-Compose
# RUN curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
#     chmod +x /usr/local/bin/docker-compose
# RUN usermod -aG docker jenkins

# # Install Terraform
# RUN wget --quiet https://releases.hashicorp.com/terraform/1.0.9/terraform_1.0.9_linux_amd64.zip && \
#     unzip terraform_1.0.9_linux_amd64.zip && \
#     mv terraform /usr/bin && \
#     rm terraform_1.0.9_linux_amd64.zip

# USER jenkins
# EOF

# #Creting docker-compose file
# cat <<EOF > /home/ec2-user/jenkins-data/docker-compose.yml
# version: '3'
# services:
#   jenkins:
#     container_name: jenkins-server
#     image: jenkins:bootcamp
#     build:
#       context: .
#     ports:
#       - "80:8080"
#     volumes:
#       - /home/ec2-user/jenkins-data/jenkins_home:/var/jenkins_home
#       - /var/run/docker.sock:/var/run/docker.sock
#     networks:
#       - net
# networks:
#   net:
# EOF

# #Build Docker Image and start container
# cd /home/ec2-user/jenkins-data && \
# docker-compose build && \
# docker-compose up -d
