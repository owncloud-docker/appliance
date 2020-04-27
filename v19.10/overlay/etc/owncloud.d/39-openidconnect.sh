#!/usr/bin/env bash
if [ -z "$OPENID_PROVIDER_URL" ]
then
  echo "Disabling OpenID Connect app..."
  occ app:disable -n openidconnect
  echo "Removing OpenID Connect config file (if existing)..."
  rm -rf ${OWNCLOUD_VOLUME_CONFIG}/openidconnect.config.php
else
  echo "Writing OpenID Connect config file..."
  gomplate \
    -f /etc/templates/openidconnect.config.php \
    -o ${OWNCLOUD_VOLUME_CONFIG}/openidconnect.config.php

  echo "Enabling OpenID Connect app..."
  occ app:enable -n openidconnect

  echo "Forcing user sync from LDAP..."
  occ user:sync -m disable 'OCA\User_LDAP\User_Proxy' || true
fi

true
