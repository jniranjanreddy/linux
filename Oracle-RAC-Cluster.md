## Source: http://www.mrmarkyoung.com/oracle/2017/08/16/everything-rac-cheat-sheet/
```
he is to guide you through the Oracle RAC clustered system
CRSCTL Command

Note: -Any command which just needs to query information can be run using oracle user. But anything which alters Oracle Clusterware requires root privileges.

First set oracle environment to CRS

Start Oracle Clusterware

UNIX>crsctl start crs
1
UNIX>crsctl start crs
Stop Oracle Clusterware

UNIX>crsctl stop crs
1
UNIX>crsctl stop crs
Enable Oracle Clusterware

UNIX>crsctl enable crs
1
UNIX>crsctl enable crs
This enables automatic startup of Clusterware daemons

Disable Oracle Clusterware

UNIX>crsctl disable crs
1
UNIX>crsctl disable crs
It disables automatic startup of Clusterware daemons. This is useful when you are performing some operations like OS patching and does not want clusterware to start the daemons automatically.

Checking Voting disk Location

UNIX>crsctl query css votedisk
##  STATE    File Universal Id                File Name Disk group
--  -----    -----------------                --------- ---------
 1. ONLINE   9032f8742b1f4f82bf95c1ef9d433939 (/dev/rdsk/c0d2s0) [DATA]
Located 1 voting disk(s).

1
2
3
4
5
UNIX>crsctl query css votedisk
##  STATE    File Universal Id                File Name Disk group
--  -----    -----------------                --------- ---------
 1. ONLINE   9032f8742b1f4f82bf95c1ef9d433939 (/dev/rdsk/c0d2s0) [DATA]
Located 1 voting disk(s).
Add Voting disk

UNIX>crsctl add css votedisk path
1
UNIX>crsctl add css votedisk path
Remove Voting disk

UNIX>crsctl delete css votedisk path
1
UNIX>crsctl delete css votedisk path
Check CRS Status

UNIX>crsctl check crs
CRS-4638: Oracle High Availability Services is online
CRS-4537: Cluster Ready Services is online
CRS-4529: Cluster Synchronization Services is online
CRS-4533: Event Manager is online
Event Manager appears healthy
1
2
3
4
5
6
UNIX>crsctl check crs
CRS-4638: Oracle High Availability Services is online
CRS-4537: Cluster Ready Services is online
CRS-4529: Cluster Synchronization Services is online
CRS-4533: Event Manager is online
Event Manager appears healthy
Check daemon status

UNIX>crsctl check cssd
CRS-272: This command remains for backward compatibility only
Cluster Synchronization Services is online
 
UNIX>crsctl check evmd
CRS-272: This command remains for backward compatibility only
Event Manager is online
1
2
3
4
5
6
7
UNIX>crsctl check cssd
CRS-272: This command remains for backward compatibility only
Cluster Synchronization Services is online
 
UNIX>crsctl check evmd
CRS-272: This command remains for backward compatibility only
Event Manager is online
Check Clusterware status on all nodes using

UNIX>crsctl check cluster -all
**************************************************************
oradbaud02:
CRS-4537: Cluster Ready Services is online
CRS-4529: Cluster Synchronization Services is online
CRS-4533: Event Manager is online
**************************************************************
oradbaud03:
CRS-4537: Cluster Ready Services is online
CRS-4529: Cluster Synchronization Services is online
CRS-4533: Event Manager is online
**************************************************************
oradbaud04:
CRS-4537: Cluster Ready Services is online
CRS-4529: Cluster Synchronization Services is online
CRS-4533: Event Manager is online
**************************************************************
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
UNIX>crsctl check cluster -all
**************************************************************
oradbaud02:
CRS-4537: Cluster Ready Services is online
CRS-4529: Cluster Synchronization Services is online
CRS-4533: Event Manager is online
**************************************************************
oradbaud03:
CRS-4537: Cluster Ready Services is online
CRS-4529: Cluster Synchronization Services is online
CRS-4533: Event Manager is online
**************************************************************
oradbaud04:
CRS-4537: Cluster Ready Services is online
CRS-4529: Cluster Synchronization Services is online
CRS-4533: Event Manager is online
**************************************************************
Determine the software version (binary version of the software on a particular cluster node)

UNIX>crsctl query crs softwareversion
Oracle Clusterware version on node [oradbaud03] is [12.1.0.1.0]
1
2
UNIX>crsctl query crs softwareversion
Oracle Clusterware version on node [oradbaud03] is [12.1.0.1.0]
Checking active version on cluster

UNIX> crsctl query crs activeversion
Oracle Clusterware active version on the cluster is [12.1.0.1.0]
1
2
UNIX> crsctl query crs activeversion
Oracle Clusterware active version on the cluster is [12.1.0.1.0]
As per documentation, multiple versions are used while upgrading. There are other options for CRSCTL too which can be seen using

UNIX>crsctl
Or
UNIX>crsctl help
1
2
3
UNIX>crsctl
Or
UNIX>crsctl help
Check the status of the cluster

UNIX>crsctl stat res -t
1
UNIX>crsctl stat res -t
or an alias crsstat

$ crsstat
--------------------------------------------------------------------------------
Name           Target  State        Server                   State details
--------------------------------------------------------------------------------
Local Resources
--------------------------------------------------------------------------------
ora.DATA.dg
               ONLINE  ONLINE       oradbaud02               STABLE
               ONLINE  ONLINE       oradbaud03               STABLE
               ONLINE  ONLINE       oradbaud04               STABLE
ora.FRA.dg
               ONLINE  ONLINE       oradbaud02               STABLE
               ONLINE  ONLINE       oradbaud03               STABLE
               ONLINE  ONLINE       oradbaud04               STABLE
ora.LISTENER.lsnr
               ONLINE  ONLINE       oradbaud02               STABLE
               ONLINE  ONLINE       oradbaud03               STABLE
               ONLINE  ONLINE       oradbaud04               STABLE
ora.asm
               ONLINE  ONLINE       oradbaud02               Started,STABLE
               ONLINE  ONLINE       oradbaud03               Started,STABLE
               ONLINE  ONLINE       oradbaud04               Started,STABLE
ora.net1.network
               ONLINE  ONLINE       oradbaud02               STABLE
               ONLINE  ONLINE       oradbaud03               STABLE
               ONLINE  ONLINE       oradbaud04               STABLE
ora.ons
               ONLINE  ONLINE       oradbaud02               STABLE
               ONLINE  ONLINE       oradbaud03               STABLE
               ONLINE  ONLINE       oradbaud04               STABLE
--------------------------------------------------------------------------------
Cluster Resources
--------------------------------------------------------------------------------
ora.LISTENER_SCAN1.lsnr
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.LISTENER_SCAN2.lsnr
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.LISTENER_SCAN3.lsnr
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.MGMTLSNR
      1        ONLINE  ONLINE       oradbaud02               169.254.19.185 172.1
                                                             8.64.97 172.18.64.11
                                                             3,STABLE
ora.NEWDSSOAD01.DSSOAD011.inst
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWDSSOAD01.DSSOAD012.inst
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWDSSOAD01.DSSOAD013.inst
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWDSSOAD01.db
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWDSSOAQ01.DSSOAQ011.inst
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWDSSOAQ01.DSSOAQ012.inst
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWDSSOAQ01.DSSOAQ013.inst
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWDSSOAQ01.db
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWDSSOAQ02.DSSOAQ021.inst
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWDSSOAQ02.DSSOAQ022.inst
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWDSSOAQ02.DSSOAQ023.inst
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWDSSOAQ02.DSSOAQ2.DSSOAQ021.srv
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWDSSOAQ02.DSSOAQ2.DSSOAQ022.srv
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWDSSOAQ02.DSSOAQ2.DSSOAQ023.srv
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWDSSOAQ02.DSSOAQ2.cs
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWDSSOAQ02.db
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWSOAD01.SOAD011.inst
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWSOAD01.SOAD012.inst
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWSOAD01.SOAD013.inst
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWSOAD01.db
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWSOAD02.SOAD021.inst
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWSOAD02.SOAD022.inst
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWSOAD02.SOAD023.inst
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWSOAD02.db
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWSOAD03.SOAD031.inst
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWSOAD03.SOAD032.inst
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWSOAD03.SOAD033.inst
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWSOAD03.db
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWSOAD04.SOAD041.inst
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWSOAD04.SOAD042.inst
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWSOAD04.SOAD043.inst
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWSOAD04.SOAD4.SOAD041.srv
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWSOAD04.SOAD4.SOAD042.srv
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWSOAD04.SOAD4.SOAD043.srv
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWSOAD04.SOAD4.cs
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWSOAD04.db
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWSOAQ01.SOAQ011.inst
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWSOAQ01.SOAQ012.inst
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWSOAQ01.SOAQ013.inst
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWSOAQ01.db
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWSOAQ02.SOAQ021.inst
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWSOAQ02.SOAQ022.inst
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWSOAQ02.SOAQ023.inst
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWSOAQ02.db
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.cvu
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.mgmtdb
      1        ONLINE  ONLINE       oradbaud02               Open,STABLE
ora.oc4j
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.oradbaud02.vip
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.oradbaud03.vip
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.oradbaud04.vip
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.scan1.vip
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.scan2.vip
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.scan3.vip
      1        ONLINE  ONLINE       oradbaud02               STABLE
--------------------------------------------------------------------------------
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95
96
97
98
99
100
101
102
103
104
105
106
107
108
109
110
111
112
113
114
115
116
117
118
119
120
121
122
123
124
125
126
127
128
129
130
131
132
133
134
135
136
137
138
139
140
141
142
143
144
145
146
147
148
149
150
$ crsstat
--------------------------------------------------------------------------------
Name           Target  State        Server                   State details
--------------------------------------------------------------------------------
Local Resources
--------------------------------------------------------------------------------
ora.DATA.dg
               ONLINE  ONLINE       oradbaud02               STABLE
               ONLINE  ONLINE       oradbaud03               STABLE
               ONLINE  ONLINE       oradbaud04               STABLE
ora.FRA.dg
               ONLINE  ONLINE       oradbaud02               STABLE
               ONLINE  ONLINE       oradbaud03               STABLE
               ONLINE  ONLINE       oradbaud04               STABLE
ora.LISTENER.lsnr
               ONLINE  ONLINE       oradbaud02               STABLE
               ONLINE  ONLINE       oradbaud03               STABLE
               ONLINE  ONLINE       oradbaud04               STABLE
ora.asm
               ONLINE  ONLINE       oradbaud02               Started,STABLE
               ONLINE  ONLINE       oradbaud03               Started,STABLE
               ONLINE  ONLINE       oradbaud04               Started,STABLE
ora.net1.network
               ONLINE  ONLINE       oradbaud02               STABLE
               ONLINE  ONLINE       oradbaud03               STABLE
               ONLINE  ONLINE       oradbaud04               STABLE
ora.ons
               ONLINE  ONLINE       oradbaud02               STABLE
               ONLINE  ONLINE       oradbaud03               STABLE
               ONLINE  ONLINE       oradbaud04               STABLE
--------------------------------------------------------------------------------
Cluster Resources
--------------------------------------------------------------------------------
ora.LISTENER_SCAN1.lsnr
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.LISTENER_SCAN2.lsnr
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.LISTENER_SCAN3.lsnr
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.MGMTLSNR
      1        ONLINE  ONLINE       oradbaud02               169.254.19.185 172.1
                                                             8.64.97 172.18.64.11
                                                             3,STABLE
ora.NEWDSSOAD01.DSSOAD011.inst
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWDSSOAD01.DSSOAD012.inst
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWDSSOAD01.DSSOAD013.inst
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWDSSOAD01.db
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWDSSOAQ01.DSSOAQ011.inst
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWDSSOAQ01.DSSOAQ012.inst
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWDSSOAQ01.DSSOAQ013.inst
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWDSSOAQ01.db
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWDSSOAQ02.DSSOAQ021.inst
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWDSSOAQ02.DSSOAQ022.inst
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWDSSOAQ02.DSSOAQ023.inst
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWDSSOAQ02.DSSOAQ2.DSSOAQ021.srv
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWDSSOAQ02.DSSOAQ2.DSSOAQ022.srv
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWDSSOAQ02.DSSOAQ2.DSSOAQ023.srv
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWDSSOAQ02.DSSOAQ2.cs
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWDSSOAQ02.db
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWSOAD01.SOAD011.inst
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWSOAD01.SOAD012.inst
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWSOAD01.SOAD013.inst
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWSOAD01.db
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWSOAD02.SOAD021.inst
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWSOAD02.SOAD022.inst
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWSOAD02.SOAD023.inst
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWSOAD02.db
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWSOAD03.SOAD031.inst
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWSOAD03.SOAD032.inst
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWSOAD03.SOAD033.inst
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWSOAD03.db
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWSOAD04.SOAD041.inst
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWSOAD04.SOAD042.inst
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWSOAD04.SOAD043.inst
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWSOAD04.SOAD4.SOAD041.srv
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWSOAD04.SOAD4.SOAD042.srv
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWSOAD04.SOAD4.SOAD043.srv
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWSOAD04.SOAD4.cs
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWSOAD04.db
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWSOAQ01.SOAQ011.inst
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWSOAQ01.SOAQ012.inst
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWSOAQ01.SOAQ013.inst
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWSOAQ01.db
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWSOAQ02.SOAQ021.inst
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.NEWSOAQ02.SOAQ022.inst
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.NEWSOAQ02.SOAQ023.inst
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.NEWSOAQ02.db
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.cvu
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.mgmtdb
      1        ONLINE  ONLINE       oradbaud02               Open,STABLE
ora.oc4j
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.oradbaud02.vip
      1        ONLINE  ONLINE       oradbaud02               STABLE
ora.oradbaud03.vip
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.oradbaud04.vip
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.scan1.vip
      1        ONLINE  ONLINE       oradbaud04               STABLE
ora.scan2.vip
      1        ONLINE  ONLINE       oradbaud03               STABLE
ora.scan3.vip
      1        ONLINE  ONLINE       oradbaud02               STABLE
--------------------------------------------------------------------------------
You are looking for anything that is not online, however oc4j may sometimes be offline

OLSNODES
1
OLSNODES
The OLSNODES command provides the list of nodes and other information for all nodes participating in the cluster.

UNIX>olsnodes
oradbaud02
oradbaud03
oradbaud04
1
2
3
4
UNIX>olsnodes
oradbaud02
oradbaud03
oradbaud04
SERVER CONTROL

SRVCTL is used to manage configuration information. You can use SRVCTL commands to add, remove, start, stop, modify, enable, and disable a number of entities, such as databases, instances, listeners, SCAN listeners, services, grid naming service (GNS), and Oracle ASM.

Note: You must use the srvctl version relevant to the version of the database. i.e. set the Oracle environment relevant.

Database

To start or stop all instances in a cluster

srvctl start database -d  -o
srvctl stop database -d  -o
e.g.
srvctl start database -d NEWSOAQ02
srvctl start database -d NEWDSS03PRD
srvctl stop database -d NEWDSS03PRD
1
2
3
4
5
6
srvctl start database -d  -o
srvctl stop database -d  -o
e.g.
srvctl start database -d NEWSOAQ02
srvctl start database -d NEWDSS03PRD
srvctl stop database -d NEWDSS03PRD
Note: starts listeners if not already running, you can use the -o option to specify startup/shutdown options

Instance

srvctl stop instance -d  -i  -o
e.g.
srvctl stop instance -d NEWSOAQ02 -i DSSOAQ021
or
srvctl start instance -d NEWSOAQ02 -i DSSOAQ021 -o mount (if you require the database to be mounted, default is open)
1
2
3
4
5
srvctl stop instance -d  -i  -o
e.g.
srvctl stop instance -d NEWSOAQ02 -i DSSOAQ021
or
srvctl start instance -d NEWSOAQ02 -i DSSOAQ021 -o mount (if you require the database to be mounted, default is open)
Status

srvctl status database -d 
srvctl status instance -d  -i ,
srvctl status service -d      
srvctl status nodeapps -n 
srvctl status asm -n
1
2
3
4
5
srvctl status database -d 
srvctl status instance -d  -i ,
srvctl status service -d      
srvctl status nodeapps -n 
srvctl status asm -n
Nodeapps

Nodeapp Services run on each node of the cluster and will switched over to other nodes through VIP during the failover.

Nodeapps are standard set of oracle application services which are started automatically for RAC. They include:
• Virtual IPs
• Oracle Net Listener
• Global Service Daemon • Oracle Notification Services.

srvctl config nodeapps
Network 1 exists
Subnet IPv4: 10.65.0.0/255.255.240.0/vnet0, static
Subnet IPv6:
VIP exists: network number 1, hosting node oradbaud02
VIP Name: oradbaud02-vip
VIP IPv4 Address: 10.65.3.65
VIP IPv6 Address:
VIP exists: network number 1, hosting node oradbaud03
VIP Name: oradbaud03-vip
VIP IPv4 Address: 10.65.3.66
VIP IPv6 Address:
VIP exists: network number 1, hosting node oradbaud04
VIP Name: oradbaud04-vip
VIP IPv4 Address: 10.65.3.67
VIP IPv6 Address:
ONS exists: Local port 6100, remote port 6200, EM port 2016
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
srvctl config nodeapps
Network 1 exists
Subnet IPv4: 10.65.0.0/255.255.240.0/vnet0, static
Subnet IPv6:
VIP exists: network number 1, hosting node oradbaud02
VIP Name: oradbaud02-vip
VIP IPv4 Address: 10.65.3.65
VIP IPv6 Address:
VIP exists: network number 1, hosting node oradbaud03
VIP Name: oradbaud03-vip
VIP IPv4 Address: 10.65.3.66
VIP IPv6 Address:
VIP exists: network number 1, hosting node oradbaud04
VIP Name: oradbaud04-vip
VIP IPv4 Address: 10.65.3.67
VIP IPv6 Address:
ONS exists: Local port 6100, remote port 6200, EM port 2016

```
