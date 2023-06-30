## How to run Django web App.
## if pip fails to psycopg2, 
```
apt-get install python-dev libpq-dev
pip install psycopg2
```

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

uwsgi --http :8000 --wsgi-file test.py
apt-get install nginx
cat /etc/nginx/sites-available/microdomains.conf
upstream django {
   server unix:////root/microdomains/microdomains.sock;
}

server {
    listen          80;
    server_name     minikube02.jnrlabs.com;
    charset utf-8;
    client_max_body_size 75M;

    # Django /media and Static Files
    location /media {
        alias /root/microdomains/media;
        }
        location /static {
        alias /root/microdomains/static;
        }

    # Send all non-media requests to the Django Server.
    location / {
           uwsgi_pass django;
           include /root/microdomains/uwsgi_params;
        }
}

cat uwsgi_params
uwsgi_param QUERY_STRING    $query_string;
uwsgi_param REQUEST_METHOD  $request_method;
uwsgi_param CONTENT_TYPE    $content_type;
uwsgi_param CONTENT_LENGTH  $content_length;
uwsgi_param REQUEST_URI     $request_uri;
uwsgi_param PATH_INFO       $document_uri;
uwsgi_param DOCUMENT_ROOT   $document_root;
uwsgi_param SERVER_PROTOCOL $server_protocol;
uwsgi_param REQUEST_SCHEME  $scheme;
uwsgi_param HTTPS           $https if_not_empty;
uwsgi_param REMOTE_ADDR     $remote_addr;
uwsgi_param REMOTE_PORT     $remote_port;
uwsgi_param SERVER_PORT     $server_port;
uwsgi_param SERVER_NAME     $server_name;

(md) root@minikube02:~/microdomains# pwd
/root/microdomains

(md) root@minikube02:~/microdomains# ln -s /etc/nginx/sites-available/microdomains.conf /etc/nginx/sites-enabled/


```
