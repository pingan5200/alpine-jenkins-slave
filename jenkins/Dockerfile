FROM harbor.qipeipu.net/base/alpine-jdk:v8-1

LABEL maintainer luchangshan


# git nodejs maven
RUN  apk update  && \
     apk add  openrc git nodejs less openssh sudo vim rsync lftp curl bash perl sshpass && \ 
     curl -O http://ops-download.qipeipu.net/download/apache-maven-3.2.3.tar.gz && \
     tar -zxf  apache-maven-3.2.3.tar.gz -C  /tmp  && \
     ln -s /tmp/apache-maven-3.2.3   /usr/local/maven && \
     ln -s /usr/bin/lftp  /usr/bin/ftp && \
     rm -rf /var/lib/apt/lists/* && \
     rm /var/cache/apk/* && \
     rm -rf  apache-maven-3.2.3.tar.gz && \
     mkdir /usr/share/cowsay  
     
#USER jenkins
COPY cowthink /usr/bin/
COPY default.cow  /usr/share/cowsay/
COPY ./java.sh  /etc/profile.d/
RUN adduser jenkins -D  -s /bin/bash -h /var/lib/jenkins  \
    && mkdir -p /home/branch_merge_to_beta/config/ \
    && chmod +x /usr/bin/cowthink \
    && echo "export MAVEN_OPTS=-Xmx8192m"  >>  /etc/profile  \
    && echo -e 'Mp9$#lV3A7\nMp9$#lV3A7' | passwd jenkins

#SSHD
RUN mkdir -p /var/lib/jenkins/.ssh
COPY sshd_config  /etc/ssh/sshd_config 
COPY ./jenkins_key  /var/lib/jenkins/.ssh
COPY ./root_key    /root/.ssh
RUN chown -R jenkins:jenkins /var/lib/jenkins && \
    chmod 600 /var/lib/jenkins/.ssh/*

#GIT
COPY ./git/config /root/.ssh/

#scripts 
COPY run.sh  /usr/local/scripts/

#zabbix agent 
RUN apk add zabbix-agent net-snmp net-snmp-tools openrc net-snmp  && \
    rc-update add zabbix-agentd  && \
    sed -i 's/x:30:/x:30:zabbix/g' /etc/group && \
    chmod +x /usr/local/scripts/run.sh


ENTRYPOINT  /usr/local/scripts/run.sh
