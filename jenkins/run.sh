#!/bin/bash
echo "Server=172.16.16.55" > /etc/zabbix/zabbix_agentd.conf 
echo "ServerActive=172.16.16.55" >> /etc/zabbix/zabbix_agentd.conf 
echo "Hostname=$slave"  >> /etc/zabbix/zabbix_agentd.conf  
echo "ListenPort=10050"  >> /etc/zabbix/zabbix_agentd.conf 
echo "PidFile=/var/run/zabbix/zabbix_agentd.pid"  >> /etc/zabbix/zabbix_agentd.conf 
echo "LogFile=/var/log/zabbix/zabbix_agentd.log"   >> /etc/zabbix/zabbix_agentd.conf 
source /etc/profile
#echo "master: $master" >> /etc/salt/minion
#echo "id: $slave" >> /etc/salt/minion
/usr/sbin/zabbix_agentd
#/etc/init.d/salt-minion start & 
/usr/sbin/sshd -D 
