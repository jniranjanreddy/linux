## https://www.youtube.com/watch?v=DzXCHAuHf0I
```
(demo) root@genchop7 /srv # mkdir www
(demo) root@genchop7 /srv # cd www/
(demo) root@genchop7 /srv/www # django-admin startproject ytdemo


mkdir /srv/www/ytdemo/logs/
touch /srv/www/ytdemo/logs/access.log
touch /srv/www/ytdemo/logs/error.log

chown nginx:nginx -R ytdemo/*
mkdir /srv/www/ytdemo/static
mkdir /srv/www/ytdemo/media


mkdir /etc/uwsgi
mkdir /etc/uwsgi/log
mkdir /etc/uwsgi/vassals
cat /etc/uwsgi/vassals/demo.ini


cat /etc/uwsgi/emperor.ini
[uwsgi]
emperor = /etc/uwsgi/vassals
uid = uwsgi
gid = nginx
logto = /etc/uwsgi/log

cat /etc/uwsgi/vassals/demo.ini
[uwsgi]
http = :8000
socket = /etc/uwsgi/sock/ytdemo.sock
chdir = /srv/www/ytdemo
pythonpath = /srv/www/ytdemo/ytdemo
home = /root/python-virtial-env/demo/
module = ytdemo.wsgi
uid = uwsgi
chmod-socket = 777
chown-socket = uwsgi
(demo) root@chop8-dev /srv/www
```

## Comment server block on nginx.
```
(demo) root@chop8-dev /srv/www # cat /etc/nginx/nginx.conf
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user nginx;
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

#    server {
#        listen       80 default_server;
#        listen       [::]:80 default_server;
#        server_name  _;
#        root         /usr/share/nginx/html;
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
(demo) root@chop8-dev /srv/www #
```

## Create a virtual file
```
(demo) root@genchop7 /srv/www # cat /etc/nginx/conf.d/virtual.conf
server {
    listen          80;
    server_name     192.168.9.90;
    error_log /srv/www/ytdemo/logs/error.log;
    access_log /srv/www/ytdemo/logs/access.log;
    charset utf-8;

       # Django /static and Static Files
    location /static/ {
        alias /srv/www/ytdemo/static/;
        }
    location /media/ {
        alias /srv/www/ytdemo/media/;
        }

        # Send all non-media requests to the Django Server.
    location / {
           uwsgi_pass unix:/etc/uwsgi/sock/ytdemo.sock;
           include uwsgi_params;
        }
}












(demo) root@genchop7 /etc # pwd
/etc
(demo) root@genchop7 /etc # ls -ld uwsgi/
drwxrwxrwx 4 uwsgi uwsgi 63 Dec  2 17:58 uwsgi/

(demo) root@genchop7 /etc # cd uwsgi/
(demo) root@genchop7 /etc/uwsgi # ll
total 612
-rwxr-xr-x 1 uwsgi uwsgi     85 Dec  2 17:57 emperor.ini
-rwxrwxrwx 1 uwsgi uwsgi 619262 Dec  2 18:04 log
drwxrwxrwx 2 uwsgi uwsgi     25 Dec  2 18:04 sock
drwxr-xr-x 2 uwsgi uwsgi     22 Dec  2 17:59 vassals


(demo) root@genchop7 /etc/uwsgi # cat emperor.ini
[uwsgi]
emperor = /etc/uwsgi/vassals
uid = uwsgi
gid = nginx
logto = /etc/uwsgi/log


(demo) root@genchop7 /etc/uwsgi # cat vassals/demo.ini
[uwsgi]
http = :8000
socket = /etc/uwsgi/sock/ytdemo.sock
chdir = /srv/www/ytdemo
pythonpath = /srv/www/ytdemo/ytdemo
home = /root/python-virtial-env/demo/
module = ytdemo.wsgi
uid = uwsgi
chmod-socket = 777
chown-socket = uwsgi

(demo) root@genchop7 /etc/uwsgi # systemctl enable uwsgi
Created symlink from /etc/systemd/system/multi-user.target.wants/uwsgi.service to /etc/systemd/system/uwsgi.service.

(demo) root@genchop7 /etc/uwsgi # cat /etc/systemd/system/uwsgi.service
[Unit]
Description=uWSGI Emperor
After=syslog.target


[Service]
ExecStart=/usr/local/bin/uwsgi --ini /etc/uwsgi/emperor.ini
ExecStop=kill -INT `cat /run/uwsgi.pid`
ExecReload=kill -TEMP `cat /run/uwsgi.pid`
Restart=always
Type=notify
NotifyAccess=main
PIDFile=/run/uwsgi.pid


[Install]
WantedBy=multi-user.target
(demo) root@genchop7 /etc/uwsgi #


```
