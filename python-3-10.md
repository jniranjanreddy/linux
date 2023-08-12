## How to install python 3.10 

```
wget https://www.python.org/ftp/python/3.10.8/Python-3.10.8.tgz 
tar xzf Python-3.10.8.tgz 
cd Python-3.10.8
./configure --with-system-ffi --with-computed-gotos --enable-loadable-sqlite-extensions
 make -j ${nproc}
make altinstall
if it failes with any zlib issues, install yum install zlib-devel.
then try make altinstall
```
