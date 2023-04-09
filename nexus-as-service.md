## How to install nexus artifactory.

# Prerequisites
Open JDK 8
Minimum CPU’s: 4
Ubuntu Server with User sudo privileges.
Set User limits
Web Browser
Firewall/Inbound port: 22, 8081

```
sudo apt-get update
sudo apt install openjdk-8-jre-headless
cd /opt
sudo wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz
tar -zxvf latest-unix.tar.gz
sudo mv /opt/nexus-3.30.1-01 /opt/nexus
sudo adduser nexus
sudo visudo
nexus ALL=(ALL) NOPASSWD: ALL
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work
sudo nano /opt/nexus/bin/nexus.rc
run_as_user="nexus"
```
vi  /opt/nexus/bin/nexus.vmoptions
```
-Xms1024m
-Xmx1024m
-XX:MaxDirectMemorySize=1024m

-XX:LogFile=./sonatype-work/nexus3/log/jvm.log
-XX:-OmitStackTraceInFastThrow
-Djava.net.preferIPv4Stack=true
-Dkaraf.home=.
-Dkaraf.base=.
-Dkaraf.etc=etc/karaf
-Djava.util.logging.config.file=/etc/karaf/java.util.logging.properties
-Dkaraf.data=./sonatype-work/nexus3
-Dkaraf.log=./sonatype-work/nexus3/log
-Djava.io.tmpdir=./sonatype-work/nexus3/tmp
```
sudo nano /etc/systemd/system/nexus.service
[Unit]
Description=nexus service
After=network.target
[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort
[Install]
WantedBy=multi-user.target
sudo systemctl start nexus
sudo systemctl enable nexus
sudo systemctl status nexus
ufw allow 8081/tcp

tail -f /opt/sonatype-work/nexus3/log/nexus.log

## After configuration
```
login to nexus as admin
goto gear icon --> create repository --> docker-hosted --> under Name registry.jnrlabs.com, select http

```
![image](https://user-images.githubusercontent.com/83489863/230779317-cecbf474-4278-4926-814a-08293b7af391.png)

![image](https://user-images.githubusercontent.com/83489863/230779373-ad341bb3-9ac2-4a6f-8e10-787a118976c7.png)
![image](https://user-images.githubusercontent.com/83489863/230779422-7f9105bf-4a49-4d08-9661-2050521c3393.png)

```
root@dev-rancher:/tmp# cat /etc/docker/daemon.json
{
  "insecure-registries" : ["registry.jnrlabs.com:8085"]
}

Restart Docker

root@dev-rancher:/tmp# docker login -u admin registry.jnrlabs.com:8085
Password:
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded

```
