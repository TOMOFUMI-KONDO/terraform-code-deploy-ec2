#!/bin/bash

yum update -y

# install nginx
amazon-linux-extras install -y nginx1
cat << EOL > /etc/nginx/conf.d/server.conf
server {
    listen  80;
    server_name localhost;

    location / {
        proxy_pass http://localhost:3000;
    }
}
EOL
systemctl start nginx
systemctl enable nginx

# install git
yum install -y git

# install nodejs, npm, yarn
curl --silent --location https://rpm.nodesource.com/setup_14.x | bash -
yum install -y nodejs
npm install -g npm
curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo
yum install -y yarn

# create app and log directory
mkdir /app
mkdir -p /var/log/app
touch /var/log/app/info.log
touch /var/log/app/error.log
chmod -R 700 /var/log/app
chown -R ec2-user:ec2-user /var/log/app
