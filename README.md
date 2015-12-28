# docker-cent6-bitnami-redmine3.2.0

## Overview

Build docker image using bitnami-redmine3.2.0 on centos6
Target Language is Japanese(If you'd like to chanege the lang-set, check below).
Not install other tools such as Git/SVN etc.


## Description

Using Dockerfile and some files to nstall bitnami-redmine stack installer automatically.
Base: CentOS6.X latest
Bitnami-redmine-stack version: redmine3.2.0-0 (As of Dec/10/2015)

The log files (such as access_log, error_log, producion.log) aggrigate into a /var/log/bitnami directory to prepare

1. for log-rotating(/etc/logrotate.d/), 
2. for viewing logs using "[Log plugin][*]". 

[*]: https://www.redmine.org/plugins/redmine_logs

Note. If you run this script on less than 2GB-based-memory system such as AWS t2.micro type,
the bitnami installer should stop and show message below.
"Bitnami Redmine Stack requires at least 2000MB of memory and the installer has detected
 XXXMB of memory. This may prevent the application from installing, working properly or
 cause it to stop functioning due to lack of memory."

## Usage
[Build] making up a contatiner(centos6:bitnami-rm320)
```
$./build.sh | tee logfile 2>&1 
```
If you keep the build-log into a file using stdout via pipe-queue.

[Execute]
```
$./start.sh
```
this script issues a command below;
```
$docker run -itd --name b-rmtest -p 10080:80 -p 10022:22 centos6:bitnami-rm311 /sbin/init
$docker ps -a
CONTAINER ID  IMAGE                 COMMAND       CREATED      STATUS      PORTS                                        NAMES
fb5ccd4f685d  centos6:bitnami-rm320 "/sbin/init"  3 hours ago  Up 3 hours  0.0.0.0:10022->22/tcp, 0.0.0.0:8080->80/tcp  rm320
```

## Notes
If you'd like to change the lamg-set, modify the files below.

1. install_bitnami.sh : line 28: send -- "**9**\n" ==> **9** is Japanese
2. Dokcerfile  : line 36: RUN ln -sf /usr/share/zoneinfo**/Asia/Tokyo** /etc/localtime  set localtime

