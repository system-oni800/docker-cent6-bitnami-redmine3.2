#!/bin/bash -x
date
# 1.DB dump
RM_BASE=/opt/redmine/mysql/bin
dirpath='/var/redmine/data'
EXT=`date +%Y%m%d`
OLDEXT=`date +%Y%m%d --date "3 day ago"`
filename=redmine320_dbbkup-$EXT
appendname=redmine320_files-$EXT

$RM_BASE/mysqldump -u bitnami -p%%DB_PASSWORD%% \
    bitnami_redmine > $dirpath/$filename.sql

chmod 700 $dirpath/$filename.sql
cd $dirpath
/bin/tar cvzf $filename.tar.gz ./$filename.sql

# 2. file backup(files,plugins,themes)

/bin/tar cvzf $appendname.tar.gz /opt/redmine/apps/redmine/htdocs/files
/bin/tar cvzf rm320-plugins-$EXT.tar.gz   /opt/redmine/apps/redmine/htdocs/plugins/
/bin/tar cvzf rm320-themes-$EXT.tar.gz    /opt/redmine/apps/redmine/htdocs/public/themes/

# 3. old file delete

rm -rf $filename.sql

rm -f redmine320_dbbkup-$OLDEXT.sql
rm -f redmine320_dbbkup-$OLDEXT.tar.gz
rm -f redmine320_files-$OLDEXT.tar.gz
rm -f rm320-plugins-$OLDEXT.tar.gz
rm -f rm320-themes-$OLDEXT.tar.gz
ls -al $dirpath

# 4. erase rotated logs

cd /var/log/archive
mv *.gz     /var/logarchive/

cd /var/logarchive
rm -f production.log-$OLDEXT.gz
rm -f access_log-$OLDEXT.gz
rm -f cron-$OLDEXT.gz
rm -f error_log-$OLDEXT.gz
rm -f maillog-$OLDEXT.gz
rm -f messages-$OLDEXT.gz
rm -f mysqld.log-$OLDEXT.gz
rm -f production.log-$OLDEXT.gz
rm -f secure-$OLDEXT.gz
rm -f smail.log-$OLDEXT.gz
pwd
ls -al

date
exit
