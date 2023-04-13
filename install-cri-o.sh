#!/bin/bash

VERSION=1.26
sudo curl -L -o /etc/yum.repos.d/devel:kubic:libcontainers:stable.repo https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/CentOS_7/devel:kubic:libcontainers:stable.repo
sudo curl -L -o /etc/yum.repos.d/devel:kubic:libcontainers:stable:cri-o:${VERSION}.repo https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:${VERSION}/CentOS_7/devel:kubic:libcontainers:stable:cri-o:${VERSION}.repo

sudo yum install cri-o cri-tools -y 
rpm -qi cri-o
systemctl enable --now crio

