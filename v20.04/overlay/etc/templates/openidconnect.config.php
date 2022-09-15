<?php
$CONFIG = [
  'openid-connect' => [
    'provider-url' => '{{.Env.OPENID_PROVIDER_URL}}',
    'client-id' => '{{.Env.OPENID_CLIENT_ID}}',
    'client-secret' => '{{.Env.OPENID_CLIENT_SECRET}}',
    'loginButtonName' => '{{getenv "OPENID_LOGIN_BUTTON_NAME" "UCS Login"}}',
    'use-token-introspection-endpoint' => false,
    'autoRedirectOnLoginPage' => {{ getenv "OPENID_AUTO_REDIRECT_TO_IDP" "false" }},
    'mode' => '{{getenv "OPENID_SEARCH_MODE" "email"}}',
    'search-attribute' => '{{getenv "OPENID_SEARCH_CLAIM" "email"}}',
  ],
];
