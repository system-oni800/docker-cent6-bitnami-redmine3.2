#!/bin/sh

# -----------------------
echo "*Start install bitnami.."
date
/root/install_bitnami.sh

echo "End install bitnami script."
# -----------------------
date
echo "*Set enforce status."
setenforce 0
getenforce

echo "*Start patching files."

patch -p0 /opt/redmine/ctlscript.sh < /root/patch.txt
patch -p0 /opt/redmine/apache2/conf/httpd.conf < /root/httpd-patch.txt
patch -p0 /opt/redmine/apps/redmine/htdocs/config/environments/production.rb < /root/rails-patch.txt
patch -p0 /opt/redmine/apps/redmine/htdocs/config/configuration.yml < /root/redmine-config.diff

PW=$(head -12 /opt/redmine/apps/redmine/htdocs/config/database.yml | grep password | cut -d' ' -f4)
sed -ri "s/%%DB_PASSWORD%%/$PW/" /root/redmine_dbbkup.sh


# prepare for user account for redmine
useradd redmine -u 1000 -s /bin/bash -d /opt/redmine
cp /root/.bashrc /opt/redmine/
cp /root/.bash_profile /opt/redmine/
usermod -G wheel redmine
echo -e "_SET_YOUR_PASSWORD_" | passwd --stdin redmine

echo "*Set up environment."
cp /opt/redmine/ctlscript.sh /etc/init.d/bitnami-redmine
mkdir /var/log/bitnami
mkdir /var/log/archive
touch /var/log/bitnami/production.log
chmod a+rw /var/log/bitnami/production.log
service zabbix-agent start
chkconfig zabbix-agent on
chkconfig --add bitnami-redmine
export PATH=$PATH:/opt/redmine/ruby/bin
rm -rf /root/bitnami-redmine-linux-x64.run

echo "*End of install."
date
# service bitnami-redmine restart
