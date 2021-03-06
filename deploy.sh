#!/bin/sh

ssh -o StrictHostKeyChecking=no ubuntu@$server_ip << 'ENDSSH'
  sudo apt-get update
  sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo apt-key fingerprint 0EBFCD88
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io -y
  sudo usermod -a -G docker ubuntu
  sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose

  mkdir -p /home/ubuntu/app
  cd /home/ubuntu/app
  git clone https://github.com/msalmansaeedch786/gitlab-py-redis-app.git
  cd /home/ubuntu/app/gitlab-py-redis-app/src
  docker-compose up -d
ENDSSH
