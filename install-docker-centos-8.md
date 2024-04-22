## Install docker-ce in Centos-8
```
yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
yum might report that you have none of these packages



sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo



yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

```

 sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


# If any isses with dependency issues.
yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin --allowerasing
