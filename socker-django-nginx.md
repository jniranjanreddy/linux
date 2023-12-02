## https://www.youtube.com/watch?v=DzXCHAuHf0I
```
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
