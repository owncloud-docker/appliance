#!/usr/bin/env bash

echo "Adding Trusted domains overwrite ..."
cat <<'EOF'> "${OWNCLOUD_VOLUME_CONFIG}/trusted-domains.config.php"
<?php
if (isset($_SERVER['HTTP_HOST']))
{
  $CONFIG = array ( 'trusted_domains' => array ( 'localhost', $_SERVER['HTTP_HOST'], ), );
}
else
{
  $CONFIG = array ( 'trusted_domains' => array ( 'localhost', ) );
}
EOF

true
