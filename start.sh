#/bin/bash

docker run -v /log/container/redmine3:/var/redmine3 \
        -v /log/container/redmine3/logarchive:/var/logarchive \
        -p 8080:80 -p 10022:22  \
        -itd --name rm320 centos6:bitnami-rm320  /sbin/init
