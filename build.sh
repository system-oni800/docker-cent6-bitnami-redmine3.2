#/bin/sh
echo "[STEP-01] Preparing docker build.."
date
REDMINE_VERSION=3.2.0-0
# https://bitnami.com/redirect/to/71821/bitnami-redmine-3.1.1-0-linux-x64-installer.run
# https://bitnami.com/redirect/to/73623/bitnami-redmine-3.1.1-1-linux-x64-installer.run #Update 2015/11/02
# https://bitnami.com/redirect/to/84173/bitnami-redmine-3.2.0-0-linux-x64-installer.run #Update 2015/12/08
BITNAMI_URL=https://bitnami.com/redirect/to/84173/bitnami-redmine-${REDMINE_VERSION}-linux-x64-installer.run
echo Using stack: ${BITNAMI_URL}
wget ${BITNAMI_URL}
mv bitnami-redmine-${REDMINE_VERSION}-linux-x64-installer.run bitnami-redmine-linux-x64.run
#
echo "[STEP-02] Execute to build a docker image"
date
docker build --no-cache=true --rm -t centos6:bitnami-rm320 .
date
#
