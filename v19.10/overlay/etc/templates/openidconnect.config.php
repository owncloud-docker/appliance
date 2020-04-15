<?php
$CONFIG = [
  'openid-connect' => [
    'provider-url' => '{{.Env.OPENID_PROVIDER_URL}}',
    'client-id' => '{{.Env.OPENID_CLIENT_ID}}',
    'client-secret' => '{{.Env.OPENID_CLIENT_SECRET}}',
    'loginButtonName' => 'SSO',
    'use-token-introspection-endpoint' => false,
    'autoRedirectOnLoginPage' => false,
    'mode' => 'email',
    'search-attribute' => 'email',
  ],
];
