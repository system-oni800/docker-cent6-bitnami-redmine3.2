#!/bin/bash -x
date
# 1.DB dump
RM_BASE=/opt/redmine/mysql/bin
dirpath='/var/redmine3/data'
EXT=`date +%Y%m%d`
filename=redmine_dbbkup-$EXT-1
appendname=redmine_files-$EXT-1

$RM_BASE/mysqldump -u bitnami -pee923450c7 \
    bitnami_redmine > $dirpath/$filename.sql

chmod 700 $dirpath/$filename.sql
cd $dirpath
/bin/tar cvzf $filename.tar.gz ./$filename.sql

# 2. file backup(files,plugins,themes)

/bin/tar cvzf $appendname.tar.gz /opt/redmine/apps/redmine/htdocs/files

rm -f $filename.sql
ls -al
date
exit
