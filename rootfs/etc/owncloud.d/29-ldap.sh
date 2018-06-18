#!/usr/bin/env bash
echo "[29.LDAP] Folder declaration"

# creating this directory for the drone test not to fail because of the univention mount not being there
if [ ! -d /var/lib/univention-appcenter/apps/owncloud/data/files ]
then
mkdir -p "/var/lib/univention-appcenter/apps/owncloud/data/files"
fi

OWNCLOUD_PERM_DIR="/var/lib/univention-appcenter/apps/owncloud"
OWNCLOUD_DATA="${OWNCLOUD_PERM_DIR}/data"

ls $OWNCLOUD_DATA/files/

if [ -f  $OWNCLOUD_DATA/files/tobemigrated ]
then
to_logfile () {
  tee --append /var/lib/univention-appcenter/apps/owncloud/data/files/owncloud-appcenter.log
}

eval "$(< ${OWNCLOUD_LDAP_FILE})"
echo -e "\n\n------"
cat ${OWNCLOUD_LDAP_FILE}

echo "[29.LDAP] Enable user_ldap app" 2>&1
n=1
until [ $n -ge 20 ]
do 
  r=$(occ app:enable user_ldap 2>&1)
  t=$?
  echo -n "."
  [[ $t == 0 ]] && break
  n=$(($n + 1))
  sleep 1
done
echo

echo "[29.LDAP] set ldap config with values from variables"
occ config:app:set user_ldap ldap_host --value="${LDAP_MASTER}" 2>&1 | to_logfile
occ config:app:get user_ldap ldap_host
occ config:app:set user_ldap ldap_port --value="${LDAP_MASTER_PORT}" 2>&1 | to_logfile
occ config:app:get user_ldap ldap_port
occ config:app:set user_ldap ldap_dn --value="${LDAP_HOSTDN}" 2>&1 | to_logfile
occ config:app:get user_ldap ldap_dn

while ! test -f "/etc/machine.secret"; do
  sleep 1
  echo "Still waiting"

done
echo "[29.LDAP] getting LDAP password and encoding it"

ldap_pwd_encoded=$(cat /etc/machine.secret | base64 -w 0)
echo $ldap_pwd_encoded > ldap_pwd

echo "[29.LDAP] setting ldap password"
occ config:app:set user_ldap ldap_agent_password --value="$(cat ldap_pwd)" 2>&1 | to_logfile
rm ldap_pwd

echo "[29.LDAP] setting ldap_base" 2>&1 | to_logfile
occ config:app:set user_ldap ldap_base --value="${owncloud_ldap_base}" 2>&1 | to_logfile
occ config:app:get user_ldap ldap_base

echo "[29.LDAP] configure ldap" 2>&1 | to_logfile
occ config:app:set user_ldap ldap_login_filter --value="${owncloud_ldap_loginFilter}" 2>&1 | to_logfile
occ config:app:set user_ldap ldap_User_Filter --value="${owncloud_ldap_userFilter}" 2>&1 | to_logfile
occ config:app:set user_ldap ldap_Group_Filter --value="${owncloud_ldap_groupFilter}" 2>&1 | to_logfile
occ config:app:set user_ldap ldap_Quota_Attribute --value="${owncloud_ldap_user_quotaAttribute}" 2>&1 | to_logfile
occ config:app:set user_ldap ldap_Expert_Username_Attr --value="${owncloud_ldap_internalNameAttribute}" 2>&1 | to_logfile
occ config:app:set user_ldap ldap_Expert_UUID_User_Attr --value="${owncloud_ldap_userUuid}" 2>&1 | to_logfile
occ config:app:set user_ldap ldapExpertUUIDGroupAttr --value="${owncloud_ldap_groupUuid}" 2>&1 | to_logfile
occ config:app:set user_ldap ldapEmailAttribute --value="${owncloud_ldap_internalNameAttribute}" 2>&1 | to_logfile
occ config:app:set user_ldap ldapGroupMemberAssocAttr --value="\${owncloud_ldap_memberAssoc}" 2>&1 | to_logfile
occ config:app:set user_ldap ldapBaseUsers --value="${owncloud_ldap_base_users}" 2>&1 | to_logfile
occ config:app:set user_ldap ldapBaseGroups --value="${owncloud_ldap_base_groups}" 2>&1 | to_logfile
occ config:app:set user_ldap useMemberOfToDetectMembership --value="0" 2>&1 | to_logfile
occ config:app:set user_ldap ldapConfigurationActive --value="1" 2>&1 | to_logfile

else
  
  echo "[01.PRE_INST] no previous installation found"

fi

true
