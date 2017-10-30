#!/bin/bash

wget -qO - https://d2t3ff60b2tol4.cloudfront.net/services@insynchq.com.gpg.key | apt-key add -
echo "deb http://apt.insynchq.com/`lsb_release -is | tr '[:upper:]' ''[:lower:]` `lsb_release -sc` non-free contrib" >> /etc/apt/sources.list
apt-get update
apt-get install insync -yq
