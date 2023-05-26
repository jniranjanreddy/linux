## How to configure ssl for nginx
```
sudo mkdir /etc/ssl/private
sudo chmod 700 /etc/ssl/private

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

[root@stack01 conf.d]# openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
Generating a 2048 bit RSA private key
........................................................+++
.+++
writing new private key to '/etc/ssl/private/nginx-selfsigned.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:IN
State or Province Name (full name) []:hyd
Locality Name (eg, city) [Default City]:hyd
Organization Name (eg, company) [Default Company Ltd]:nirulabs.com
Organizational Unit Name (eg, section) []:IT
Common Name (eg, your name or your server's hostname) []:stack01.nirulabs.com
Email Address []:admin@gmail.com
```
## Execute below command
```
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
```
## create /etc/nginx/conf.d/ssl.conf
```
[root@stack01 conf.d]# cat ssl.conf
server {
    listen 443 http2 ssl;
    listen [::]:443 http2 ssl;

    server_name 192.168.9.19;

    ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
    ssl_dhparam /etc/ssl/certs/dhparam.pem;

    ########################################################################
    # from https://cipherlist.eu/                                            #
    ########################################################################

    ssl_protocols TLSv1.3;# Requires nginx >= 1.13.0 else use TLSv1.2
    ssl_prefer_server_ciphers on;
    ssl_ciphers EECDH+AESGCM:EDH+AESGCM;
    ssl_ecdh_curve secp384r1; # Requires nginx >= 1.1.0
    ssl_session_timeout  10m;
    ssl_session_cache shared:SSL:10m;
    ssl_session_tickets off; # Requires nginx >= 1.5.9
    ssl_stapling on; # Requires nginx >= 1.3.7
    ssl_stapling_verify on; # Requires nginx => 1.3.7
    resolver 8.8.8.8 8.8.4.4 valid=300s;
    resolver_timeout 5s;
    # Disable preloading HSTS for now.  You can use the commented out header line that includes
    # the "preload" directive if you understand the implications.
    #add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload";
    add_header X-Frame-Options DENY;
    add_header X-Content-Type-Options nosniff;
    add_header X-XSS-Protection "1; mode=block";
    ##################################
    # END https://cipherlist.eu/ BLOCK #
    ##################################
    root /usr/share/nginx/html;

    location / {
    }

    error_page 404 /404.html;
    location = /404.html {
    }

    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
    }
}

## Ignore warning...

[root@stack01 conf.d]# nginx -t
nginx: [warn] "ssl_stapling" ignored, issuer certificate not found for certificate "/etc/ssl/certs/nginx-selfsigned.crt"
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful

```
## when you create a new conf add below lines.
```
ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
    ssl_dhparam /etc/ssl/certs/dhparam.pem;

    ########################################################################
    # from https://cipherlist.eu/                                            #
    ########################################################################

    ssl_protocols TLSv1.3;# Requires nginx >= 1.13.0 else use TLSv1.2
    ssl_prefer_server_ciphers on;
    ssl_ciphers EECDH+AESGCM:EDH+AESGCM;
    ssl_ecdh_curve secp384r1; # Requires nginx >= 1.1.0
    ssl_session_timeout  10m;
    ssl_session_cache shared:SSL:10m;
    ssl_session_tickets off; # Requires nginx >= 1.5.9
    ssl_stapling on; # Requires nginx >= 1.3.7
    ssl_stapling_verify on; # Requires nginx => 1.3.7

```
