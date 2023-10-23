## Enable yum in Centos 8

```
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Linux-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Linux-*
```

## How to install in CenOS-8
```
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf list docker-ce
dnf install docker-ce --nobest -y
systemctl start docker
systemctl enable docker
docker --version

docker run hello-world


dnf install curl -y
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version


```
## How to install Python 3.10
```
yum install openssl-devel bzip2-devel libffi-devel
yum groupinstall "Development Tools"
wget https://www.python.org/ftp/python/3.10.8/Python-3.10.8.tgz
cd Python-3.10.8
./configure --enable-optimizations
make altinstall
python3.10 -V

```










