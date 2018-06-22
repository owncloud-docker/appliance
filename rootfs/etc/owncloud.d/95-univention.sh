#!/usr/bin/env bash
#95-univention.sh

echo "[95.univeniton.sh] setting collabora URL"
if [[ "$(occ config:app:get richdocuments wopi_url)" == "" ]]
then
     occ config:app:set richdocuments wopi_url --value https://"$docker_host_name" 
fi

echo "collabora certificate check"
OWNCLOUD_PERM_DIR="/var/lib/univention-appcenter/apps/owncloud"
OWNCLOUD_DATA="${OWNCLOUD_PERM_DIR}/data"
OWNCLOUD_CONF="${OWNCLOUD_PERM_DIR}/conf"

collabora_cert=/etc/univention/ssl/ucsCA/CAcert.pem
owncloud_certs=/var/www/owncloud/resources/config/ca-bundle.crt

echo "[95.univeniton.sh] Is the collabora certificate is mounted correctly" 
if [ -f $collabora_cert ]
then
    echo "Yes.
    Was it updated?" 
    # Declaring the marker-string
    collab="This is a certificate for Collabora for ownCloud"
    if grep -Fq "$collab" "$owncloud_certs"
        then
            echo "Yes. 
            Certificate was already updated" 
        else
            echo "No. 
            Updating Certificate..." 
            echo "$collab" >> $owncloud_certs
            cat $collabora_cert >> $owncloud_certs
            echo "Certificate has been succesfully updated" 
    fi
else 
    echo "There is no Collabora Certificate"         
fi

echo "[95.univeniton.sh] configuring owncloud for onlyoffice use"
sed -i "s#);#  'onlyoffice' => array ('verify_peer_off' => TRUE),\n&#" $OWNCLOUD_CONF/config.php

else 

echo "[95.univeniton.sh] no ldap file found..."

fi

true
