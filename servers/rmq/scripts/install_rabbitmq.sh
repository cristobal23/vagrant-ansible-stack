#!/bin/sh
rpm -–import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.0.4/rabbitmq-server-3.0.4-1.noarch.rpm
yum -y install rabbitmq-server-3.0.4-1.noarch.rpm
chkconfig rabbitmq-server on
touch /var/lib/rabbitmq/rabbitmq-env.conf
echo 'RABBITMQ_NODE_IP_ADDRESS = 192.168.56.30' | sudo tee -a /var/lib/rabbitmq/rabbitmq-env.conf
sudo rabbitmq-plugins enable rabbitmq_management
sudo service rabbitmq-server start
sudo service iptables stop