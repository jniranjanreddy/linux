### Source - https://www.digitalocean.com/community/tutorials/how-to-set-up-django-with-postgres-nginx-and-gunicorn-on-centos-7
### for Postgresql- https://www.tcien.com/install-postgresql-server-12-6-on-rhel-8/


## OS part
```
sudo yum install epel-release
sudo yum install python-pip python-devel postgresql-server postgresql-devel postgresql-contrib gcc nginx 

```

## Postgresql Installation
```
yum remove postgres\*
dnf install https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
dnf -qy module disable postgresql
dnf install postgresql12
dnf install postgresql12-server
/usr/pgsql-12/bin/postgresql-12-setup initdb
systemctl enable postgresql-12
systemctl start postgresql-12

# Create database
su - postgres
psql
CREATE DATABASE myproject;
CREATE USER myprojectuser WITH PASSWORD 'password';
GRANT ALL PRIVILEGES ON DATABASE myproject TO myprojectuser;

\q
exit

## Update file /var/lib/pgsql/data/pg_hba.conf
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:
#host    all             all             127.0.0.1/32            ident
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
#host    all             all             ::1/128                 ident
host    all             all             ::1/128                 md5

```
## createing project.
## Install python3.10, my requiremnt is 3.10, so installed in 3.10, it may also work for some other versions.
```
https://github.com/jniranjanreddy/linux/blob/main/python-3-10.md

mkdir ~/myproject
cd ~/myproject
python3.10 -m venv myprojectenv
source myprojectenv/bin/activate

pip install django gunicorn psycopg2
django-admin.py startproject myproject .

# update settings.py myproject/settings.py
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'myproject',
        'USER': 'myprojectuser',
        'PASSWORD': 'password',
        'HOST': 'localhost',
        'PORT': '',
    }
}

# append in the bottom of the settings.py
STATIC_ROOT = os.path.join(BASE_DIR, "static/")

cd ~/myproject
./manage.py makemigrations
./manage.py migrate

# Create super user
./manage.py createsuperuser

# create
./manage.py collectstatic

./manage.py runserver 0.0.0.0:8000

cd ~/myproject
gunicorn --bind 0.0.0.0:8000 myproject.wsgi:application


```


## gunicorn Systemd file
```
[root@gunicornc8 myproject]# cat /etc/systemd/system/gunicorn.service
[Unit]
Description=gunicorn daemon
After=network.target

[Service]
User=root
Group=nginx
WorkingDirectory=/root/myproject
ExecStart=/root/myproject/myprojectenv/bin/gunicorn --workers 3 --bind unix:/root/myproject/myproject.sock  myproject.wsgi:application

[Install]
WantedBy=multi-user.target
```
## Nginx file.
```
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user root;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

    server {
        listen       80;
        server_name  chop.jnrlabs.com;


        location = /favicon.ico { access_log off; log_not_found off; }
        location /static/ {
            root /root/myproject;
        }

        location / {
        proxy_set_header Host $http_host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_pass http://unix:/root/myproject/myproject.sock;

    }

  }

# Settings for a TLS enabled server.
#
#    server {
#        listen       443 ssl http2 default_server;
#        listen       [::]:443 ssl http2 default_server;
#        server_name  _;
#        root         /usr/share/nginx/html;
#
#        ssl_certificate "/etc/pki/nginx/server.crt";
#        ssl_certificate_key "/etc/pki/nginx/private/server.key";
#        ssl_session_cache shared:SSL:1m;
#        ssl_session_timeout  10m;
#        ssl_ciphers PROFILE=SYSTEM;
#        ssl_prefer_server_ciphers on;
#
#        # Load configuration files for the default server block.
#        include /etc/nginx/default.d/*.conf;
#
#        location / {
#        }
#
#        error_page 404 /404.html;
#            location = /40x.html {
#        }
#
#        error_page 500 502 503 504 /50x.html;
#            location = /50x.html {
#        }
#    }

}

[root@gunicornc8 myproject]#
```
## troubleshooting
```
[root@gunicornc8 ~]# ls -ld myproject/
drwxr-xr-x 5 root root 96 Dec  3 19:24 myproject/

[root@gunicornc8 ~]# ls -ltr myproject/
total 4
drwxr-xr-x 5 root root   74 Dec  3 17:26 myprojectenv
-rwxr-xr-x 1 root root  665 Dec  3 17:36 manage.py
drwxr-xr-x 3 root root   19 Dec  3 18:16 static
drwxr-xr-x 3 root root  108 Dec  3 18:17 myproject
srwxrwxrwx 1 root nginx   0 Dec  3 19:24 myproject.sock

[root@gunicornc8 ~]# ls -ltr myproject/myproject
total 16
-rw-r--r-- 1 root root  395 Dec  3 17:36 wsgi.py
-rw-r--r-- 1 root root  765 Dec  3 17:36 urls.py
-rw-r--r-- 1 root root    0 Dec  3 17:36 __init__.py
-rw-r--r-- 1 root root  395 Dec  3 17:36 asgi.py
-rw-r--r-- 1 root root 3541 Dec  3 18:17 settings.py
drwxr-xr-x 2 root root  126 Dec  3 18:17 __pycache__

[root@gunicornc8 ~]# ls -ltr myproject/myprojectenv/
total 8
-rw-r--r-- 1 root root   76 Dec  3 17:26 pyvenv.cfg
lrwxrwxrwx 1 root root    3 Dec  3 17:26 lib64 -> lib
drwxr-xr-x 3 root root   24 Dec  3 17:26 lib
drwxr-xr-x 2 root root    6 Dec  3 17:26 include
drwxr-xr-x 2 root root 4096 Dec  3 17:28 bin

```
