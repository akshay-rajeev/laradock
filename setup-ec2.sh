#!/bin/bash

sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo usermod -a -G docker ec2-user
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose;
sudo chmod +x /usr/local/bin/docker-compose;
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo systemctl enable docker
newgrp docker << END
    sudo service docker start
    ./app.sh init
END