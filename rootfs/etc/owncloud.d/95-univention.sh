#!/usr/bin/env bash
#95-univention.sh

to_logfile () {
  tee --append /var/lib/univention-appcenter/apps/owncloud/data/files/owncloud-appcenter.log
}


echo "[95.univeniton.sh] setting up user sync in cron"
cat << EOF >| /etc/cron.d/sync
*/10  *  *  *  * root /usr/local/bin/occ user:sync -m disable 'OCA\User_LDAP\User_Proxy'
EOF
echo "[95.univeniton.sh] first user sync"
occ user:sync -m disable "OCA\User_LDAP\User_Proxy" 2>&1 | to_logfile

echo "[95.univeniton.sh] setting collabora URL"
if [[ "$(occ config:app:get richdocuments wopi_url)" == "" ]]
then
     occ config:app:set richdocuments wopi_url --value https://"$docker_host_name" 2>&1 | to_logfile
fi

echo "collabora certificate check"
OWNCLOUD_PERM_DIR="/var/lib/univention-appcenter/apps/owncloud"
OWNCLOUD_DATA="${OWNCLOUD_PERM_DIR}/data"
OWNCLOUD_CONF="${OWNCLOUD_PERM_DIR}/conf"

collabora_log=/var/lib/univention-appcenter/apps/owncloud/data/files/owncloud-appcenter.log
collabora_cert=/etc/univention/ssl/ucsCA/CAcert.pem
owncloud_certs=/var/www/owncloud/resources/config/ca-bundle.crt

echo "[95.univeniton.sh] Is the collabora certificate is mounted correctly" >> $collabora_log
if [ -f $collabora_cert ]
then
          echo "Yes.
          Was it updated?" >> $collabora_log
          # Declaring the marker-string
          collab="This is a certificate for Collabora for ownCloud"
          if grep -Fq "$collab" "$owncloud_certs"
          then
                  echo "Yes. 
                  Certificate was already updated" >> $collabora_log
          else
                  echo "No. 
                  Updating Certificate..." >>$collabora_log
                  echo "$collab" >> $owncloud_certs
                  cat $collabora_cert >> $owncloud_certs
                  echo "Certificate has been succesfully updated" >> $collabora_log
          fi
else 
          echo "There is no Collabora Certificate" >> $collabora_log        
fi

echo "[95.univeniton.sh] configuring owncloud for onlyoffice use"
sed -i "s#);#  'onlyoffice' => array ('verify_peer_off' => TRUE),\n&#" $OWNCLOUD_CONF/config.php

else 

echo "[95.univeniton.sh] no ldap file found..."

fi

true
