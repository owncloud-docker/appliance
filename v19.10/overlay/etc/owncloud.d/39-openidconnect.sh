#!/usr/bin/env bash
if [ -z "$OPENID_PROVIDER_URL" ]
then
  echo "OpenID Connect will not be enabled ...."
else
  echo "Writing OpenID Connect config file..."
  gomplate \
    -f /etc/templates/openidconnect.config.php \
    -o ${OWNCLOUD_VOLUME_CONFIG}/openidconnect.config.php

  echo "Enabling OpenID Connect app..."
  occ app:enable -n openidconnect
fi

true
