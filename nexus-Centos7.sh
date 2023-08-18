https://blog.yasithab.com/centos/install-nexus-repository-oss-on-centos-7/

yum install -y epel-release unzip vim wget
yum -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel

mkdir -p /data/nexus-data /opt/nexus
wget -O /tmp/nexus.tar.gz http://download.sonatype.com/nexus/3/latest-unix.tar.gz
tar xvfz /tmp/nexus.tar.gz -C /opt/nexus --strip-components 1
sudo useradd --system --no-create-home nexus
chown -R nexus:nexus /opt/nexus
chown -R nexus:nexus /data/nexus-data


alternatives --config java 
export JAVA_HOME=$(dirname $(dirname $(readlink $(readlink $(which javac)))))
export NEXUS_HOME=/opt/nexus
source /etc/bashrc
java -version


$NEXUS_HOME/bin/nexus.vmoptions
-Xms1200M
-Xmx1200M
-XX:MaxDirectMemorySize=4G
-XX:+UnlockDiagnosticVMOptions
-XX:+UnsyncloadClass
-XX:+LogVMOutput
-XX:LogFile=/data/nexus-data/nexus3/log/jvm.log
-Djava.net.preferIPv4Stack=true
-Dkaraf.home=.
-Dkaraf.base=.
-Dkaraf.etc=etc/karaf
-Djava.util.logging.config.file=etc/karaf/java.util.logging.properties
-Dkaraf.data=/data/nexus-data/nexus3
-Djava.io.tmpdir=/data/nexus-data/nexus3/tmp
-Dkaraf.startLocalConsole=false


$NEXUS_HOME/etc/nexus-default.properties
# Listen on localhost only
application-host=127.0.0.1

# Fix header is too large errors
jetty.request.header.size=32768
jetty.response.header.size=32768

 $NEXUS_HOME/bin/nexus.rc
 run_as_user="nexus"

/etc/systemd/system/nexus.service
[Unit]
Description=Nexus Server
After=syslog.target network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Group=nexus
Restart=on-failure

[Install]
WantedBy=multi-user.target

/etc/security/limits.conf
nexus    -    nofile    65536


sudo systemctl daemon-reload
sudo systemctl start nexus.service
sudo systemctl enable nexus.service


netstat -tulpn | grep 8081


tail -f /data/nexus-data/nexus3/log/nexus.log


