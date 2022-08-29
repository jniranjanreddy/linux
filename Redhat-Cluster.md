## Redhat Cluster..

```
yum install pcs pacemaker frnce-agents-all
systemc enable pcs
systemctl start pcs

pcs cluster enable --all
pcs cluster status
```


```
LOCATION	DESCRIPTION
/var/lib/pacemaker/cib/cib.xml	Primary cluster configuration file
/var/log/cluster/corosync.log	Primary cluster log file
/usr/lib/ocf/resource.d/heartbeat/	Directory where resource scripts are located
Check Cluster Status
COMMAND	DESCRIPTION
pcs cluster status	Display status of cluster nodes
pcs status –full (double dashes)	Display detailed cluster status of nodes and resources
pcs resource	Display status of all resources and resource groups
Modify Cluster Nodes
COMMAND	DESCRIPTION
pcs cluster standby	Place node in standby mode
pcs cluster unstandby	Remove node from standby mode
Managing Running Resources
COMMAND	DESCRIPTION
pcs resource move [resource_name] node name	Move resource to another node
pcs resource restart [resource_name]	Restart resource on current node
pcs resource enable [resource_name]	Start resource on current node
pcs resource disable [resource_name]	Stop resource on current node
Debugging Resources
COMMAND	DESCRIPTION
pcs resource debug-start [source_name]	Force resource to start on node where command is executed showing debug information. Use --full for even more verbose output.
pcs resource debug-stop [source_name]	Force resource to stop on node where command is executed showing debug information. Use --full for even more verbose output.
pcs resource debug-monitor [source_name]	Force resource to be monitored on node where command is executed showing debug information. Use --full for even more verbose output.
Creating and Modifying Resources
COMMAND	DESCRIPTION
pcs resource agents	List available resource agents
pcs resource describe [resource]	List configuration setting for resource
pcs resource create [resource id][resource] options…	Create resource
pcs resource show [resource id]	Display currently configured setting of resource
pcs resource update [resource id] options….	Update resource configuration
pcs resource delete [resource id]	Delete resource
pcs resource cleanup [resource id]	Cleanup resource failures
Creating and Modifying Stonith Resources
COMMAND	DESCRIPTION
pcs stonith list	List available fence agents
pcs stonith describe [fence agent]	List configuration settings for fence agent
pcs stonith describe [stonith_id]	List configuration setting for stonith agent
pcs stonith create [stonith_id][resource] options…	Create stonith agent
pcs stonith show [stonith_id]	Display currently configured setting of stonith agent
pcs stonith update [stonith_id] options….	Update stonith configuration
pcs stonith delete [stonith_id]	Delete stonith agent
pcs stonith cleanup [stonith_id]	Cleanup stonith agent failuresLOCATION	DESCRIPTION
/var/lib/pacemaker/cib/cib.xml	Primary cluster configuration file
/var/log/cluster/corosync.log	Primary cluster log file
/usr/lib/ocf/resource.d/heartbeat/	Directory where resource scripts are located
Check Cluster Status
COMMAND	DESCRIPTION
pcs cluster status	Display status of cluster nodes
pcs status –full (double dashes)	Display detailed cluster status of nodes and resources
pcs resource	Display status of all resources and resource groups
Modify Cluster Nodes
COMMAND	DESCRIPTION
pcs cluster standby	Place node in standby mode
pcs cluster unstandby	Remove node from standby mode
Managing Running Resources
COMMAND	DESCRIPTION
pcs resource move [resource_name] node name	Move resource to another node
pcs resource restart [resource_name]	Restart resource on current node
pcs resource enable [resource_name]	Start resource on current node
pcs resource disable [resource_name]	Stop resource on current node
Debugging Resources
COMMAND	DESCRIPTION
pcs resource debug-start [source_name]	Force resource to start on node where command is executed showing debug information. Use --full for even more verbose output.
pcs resource debug-stop [source_name]	Force resource to stop on node where command is executed showing debug information. Use --full for even more verbose output.
pcs resource debug-monitor [source_name]	Force resource to be monitored on node where command is executed showing debug information. Use --full for even more verbose output.
Creating and Modifying Resources
COMMAND	DESCRIPTION
pcs resource agents	List available resource agents
pcs resource describe [resource]	List configuration setting for resource
pcs resource create [resource id][resource] options…	Create resource
pcs resource show [resource id]	Display currently configured setting of resource
pcs resource update [resource id] options….	Update resource configuration
pcs resource delete [resource id]	Delete resource
pcs resource cleanup [resource id]	Cleanup resource failures
Creating and Modifying Stonith Resources
COMMAND	DESCRIPTION
pcs stonith list	List available fence agents
pcs stonith describe [fence agent]	List configuration settings for fence agent
pcs stonith describe [stonith_id]	List configuration setting for stonith agent
pcs stonith create [stonith_id][resource] options…	Create stonith agent
pcs stonith show [stonith_id]	Display currently configured setting of stonith agent
pcs stonith update [stonith_id] options….	Update stonith configuration
pcs stonith delete [stonith_id]	Delete stonith agent
pcs stonith cleanup [stonith_id]	Cleanup stonith agent failures


Enable Maintenance Mode
1 – Run the pcs property set maintenance-mode=true command to place the cluster into maintenance mode.

pcs property set maintenance-mode=true
 
2 – Next run the pcs property command to verity that it displays maintenance-mode: true which means the cluster is in maintenance mode.

pcs property
 
Example Output

Cluster Properties:
 cluster-infrastructure: cman
 dc-version: 1.1.15-5.el6-e174ec8
 have-watchdog: false
 last-lrm-refresh: 1527095308
 maintenance-mode: true
 no-quorum-policy: freeze
 
3 – Next run the pcs status --full command and you will see an alert at the top of the status output showing the cluster is in maintenance mode.

pcs status --full
 
Example Output

Cluster name: TEST_CLUSTER
Stack: cman
Current DC: server01-cpn (version 1.1.15-5.el6-e174ec8) - partition with quorum
Last updated: Fri Jun  1 09:25:24 2018          Last change: Fri Jun  1 09:20:51 2018 by root via cibadmin on server01-cpn
 
​              *** Resource management is DISABLED ***
  The cluster will not attempt to start, stop or recover services
 
2 nodes and 44 resources configured
 
Disable Maintenance Mode
1 – Run the pcs property set maintenance-mode=false command to take the cluster out of maintenance mode.

pcs property set maintenance-mode=false
 
2 – Next run the pcs property command to verity that it does not display maintenance-mode: true which means the cluster is not in maintenance mode.

pcs property
 
Example Output

Cluster Properties:
 cluster-infrastructure: cman
 dc-version: 1.1.15-5.el6-e174ec8
 have-watchdog: false
 last-lrm-refresh: 1527095308
 no-quorum-policy: freeze
 

Remove Constraints
1 – List the currently configured constraints using the pcs constraint list --full command.

pcs constraint list --full
 
Example Output

Location Constraints:
  Resource: test_sg
    Disabled on: server01-cpn (score:-INFINITY) (role: Started) (id:cli-ban-test_sg-on-server01-cpn)
Ordering Constraints:
Colocation Constraints:
Ticket Constraints:
 
2 – Note the id string and use that to remove the constraints use the pcs constraint remove id command.

pcs constraint remove cli-ban-test_sg-on-server01-cpn
 
3 – Verify the constraints have been removed using the pcs constraint list --full command.

pcs constraint list --full
 
Example Output

Location Constraints:
Ordering Constraints:
Colocation Constraints:
Ticket Constraints:
 
This write-up will detail the process of creating location constraints in a Pacemaker cluster. This is done when you want to have an resource or resource group prefer to run on a specific node in the cluster.

1 – Verify the current list of constraints using the pcs constraint list command.

pcs constraint list --full
 
Example Output

Location Constraints:
Ordering Constraints:
Colocation Constraints:
Ticket Constraints:
 
2 – Use the pcs constraint location command to assign your resources or resource groups to the preferred node in the cluster.

pcs constraint location test01_sg prefers server01-cpn
 
pcs constraint location test02_sg prefers server02-cpn
 
pcs constraint location test03_sg prefers server02-cpn
 
pcs constraint location test04_sg prefers server01-cpn
 
pcs constraint location test05_sg prefers server02-cpn
 
3 – Verify the constraints are configured properly using the pcs constraint list command.

pcs constraint list --full
 
Example Output

Location Constraints:
  Resource: test04_sg
​    Enabled on: server01-cpn (score:INFINITY) (id:location-test04_sg-server01-cpn-INFINITY)
  Resource: test02_sg
​    Enabled on: server02-cpn (score:INFINITY) (id:location-test02_sg-server02-cpn-INFINITY)
  Resource: test03_sg
​    Enabled on: server02-cpn (score:INFINITY) (id:location-test03_sg-server02-cpn-INFINITY)
  Resource: test05_sg
​    Enabled on: server02-cpn (score:INFINITY) (id:location-test05_sg-server02-cpn-INFINITY)
  Resource: test01_sg
​    Enabled on: server01-cpn (score:INFINITY) (id:location-test01_sg-server01-cpn-INFINITY)
Ordering Constraints:
Colocation Constraints:
Ticket Constraints:
 
```
