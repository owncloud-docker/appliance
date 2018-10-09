FROM owncloud/base:bionic

LABEL maintainer="ownCloud DevOps <devops@owncloud.com>" \
  org.label-schema.name="ownCloud Appliance" \
  org.label-schema.vendor="ownCloud GmbH" \
  org.label-schema.schema-version="1.0"

ADD owncloud-*.tar.bz2 /var/www/
ADD richdocuments.tar.gz /var/www/owncloud/apps/
ADD user_ldap.tar.gz /var/www/owncloud/apps/
ADD onlyoffice.tar.gz /var/www/owncloud/apps/

COPY rootfs /

RUN find /var/www/owncloud \( \! -user www-data -o \! -group www-data \) -print0 | xargs -r -0 chown www-data:www-data
