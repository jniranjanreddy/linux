## How to install Django in centos7.x
## Source: https://www.digitalocean.com/community/tutorials/how-to-set-up-django-with-postgres-nginx-and-gunicorn-on-centos-7
## Source: https://www.digitalocean.com/community/tutorials/how-to-serve-django-applications-with-uwsgi-and-nginx-on-centos-7
## Source: https://www.digitalocean.com/community/tutorials/how-to-set-up-uwsgi-and-nginx-to-serve-python-apps-on-centos-7


## Dockerize Django
```
https://blog.logrocket.com/dockerizing-django-app/
https://dockerize.io/guides/python-django-guide
```
```
yum groupinstall "Development Tools"
sudo yum install python3-devel
yum install gcc
sudo yum install postgresql-libs
sudo yum install postgresql-devel
[sudo] pip install psycopg2
```
## How to update sqlite3
```
cd /opt
wget https://www.sqlite.org/2019/sqlite-autoconf-3280000.tar.gz
tar -xzf sqlite-autoconf-3280000.tar.gz
cd sqlite-autoconf-3280000
./configure
make
sudo make install
```
