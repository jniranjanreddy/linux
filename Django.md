## How to run Django web App.
## Prerquisites
```
Nginx
Unix Socket
uWSGI
DJango
Python

root@minikube02:~# apt-get install python3-venv
root@minikube02:~# mkdir env
root@minikube02:~# pwd
/root

root@minikube02:~# python3 -m venv /root/env/md

root@minikube02:~# ls /root/env/md
bin  include  lib  lib64  pyvenv.cfg  share

root@minikube02:~# ls /root/env/
md

root@minikube02:~# source /root/env/md/bin/activate
(md) root@minikube02:~#

(md) root@minikube02:~# pip install Django
Collecting Django
  Downloading Django-4.2.1-py3-none-any.whl (8.0 MB)
     |████████████████████████████████| 8.0 MB 5.2 MB/s
Collecting sqlparse>=0.3.1
  Downloading sqlparse-0.4.4-py3-none-any.whl (41 kB)
     |████████████████████████████████| 41 kB 142 kB/s
Collecting asgiref<4,>=3.6.0
  Downloading asgiref-3.6.0-py3-none-any.whl (23 kB)
Collecting backports.zoneinfo; python_version < "3.9"
  Downloading backports.zoneinfo-0.2.1-cp38-cp38-manylinux1_x86_64.whl (74 kB)
     |████████████████████████████████| 74 kB 1.1 MB/s
Installing collected packages: sqlparse, asgiref, backports.zoneinfo, Django
Successfully installed Django-4.2.1 asgiref-3.6.0 backports.zoneinfo-0.2.1 sqlparse-0.4.4
(md) root@minikube02:~#

(md) root@minikube02:~# django-admin startproject microdomains
(md) root@minikube02:~# ls
dns-bootstrap.sh  env  microdomains  mySpace  snap

(md) root@minikube02:~# ls microdomains/microdomains/
asgi.py  __init__.py  settings.py  urls.py  wsgi.py

(md) root@minikube02:~# cd microdomains/
(md) root@minikube02:~/microdomains# ls
manage.py  microdomains
(md) root@minikube02:~/microdomains#

(md) root@minikube02:~/microdomains# python manage.py runserver 0.0.0.0:8000
Watching for file changes with StatReloader
Performing system checks...

System check identified no issues (0 silenced).

You have 18 unapplied migration(s). Your project may not work properly until you apply the migrations for app(s): admin, auth, contenttypes, sessions.
Run 'python manage.py migrate' to apply them.
May 05, 2023 - 13:28:16
Django version 4.2.1, using settings 'microdomains.settings'
Starting development server at http://0.0.0.0:8000/
Quit the server with CONTROL-C

# Allow hosts..
vim microdomains/settings.py
ALLOWED_HOSTS = ['minikube02.jnrlabs.com', 'www.jnrlabs.com']

apt-get update
apt-get install python3.8-dev -y
apt-get install gcc -y
pip install uwsgi


(md) root@minikube02:~/microdomains# pwd
/root/microdomains
(md) root@minikube02:~/microdomains# cat test.py
def application(env, start_response):
    start_response('200 OK', [('Content-Type','text/html')])
    return [b"Hello World"]
```
