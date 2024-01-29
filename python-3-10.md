## How to install python 3.10 

```
yum update
yum install openssl-devel bzip2-devel libffi-devel
yum groupinstall "Development Tools"
yum install sqlite-devel

wget https://www.python.org/ftp/python/3.10.8/Python-3.10.8.tgz 
tar xzf Python-3.10.8.tgz 
cd Python-3.10.8
./configure --with-system-ffi --with-computed-gotos --enable-loadable-sqlite-extensions
make -j ${nproc}
make altinstall
if it failes with any zlib issues, install yum install zlib-devel.
then try make altinstall
```
CHAP install
![image](https://github.com/jniranjanreddy/linux/assets/83489863/33233edc-2259-446c-a968-6915c59ec95b)

```
python3.10 -m venv non-docker-1
source non-docker-1/bin/activate
pip install -r requirements.txt
python3.10 bin/manage.py migrate
python3.10 bin/manage.py makemigrations
python3.10 bin/manage.py createsuperuser
python3.10 bin/manage.py runserver or python3.10 bin/manage.py runserver 0.0.0.0:8000

```
## Service
```
cat /lib/systemd/system/manaKonnect.service
[Unit]
Description=Start Manakannaction App

[Service]
Type=forking
WorkingDirectory=/root/non-docker-1/
ExecStart=/usr/local/bin/ManaKonnection.sh

[Install]
WantedBy=multi-user.target
--------------------------
ls -ld /usr/local/bin/ManaKonnection.sh
-rwxr-xr-x. 1 root root 207 Oct 26 15:54 /usr/local/bin/ManaKonnection.sh

cat /usr/local/bin/ManaKonnection.sh
#!/usr/bin/env bash
source bin/activate
nohup python3.10 ManaKonnection/bin/manage.py runserver 10.1.10.109:8000 &


if any issues like this below, then install pip install psycopg2-binary

pg_config is required to build psycopg2 from source
pip install psycopg2-binary

```
