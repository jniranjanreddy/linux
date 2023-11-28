## How to install python 3.10 

```
yum update

yum install openssl-devel bzip2-devel libffi-devel

yum groupinstall "Development Tools"

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
```
python3.10 -m venv non-docker-1
source non-docker-1/bin/activate
pip install -r requirements.txt
python3.10 bin/manage.py runserver
```
