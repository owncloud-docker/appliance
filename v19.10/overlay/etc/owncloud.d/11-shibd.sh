#!/usr/bin/env bash

echo "[11.shibd.sh] check if ucs shibd service exists... "
if service --status-all | grep -Fq 'shibd'; then   
  echo "[11.shibd.sh] shibd found, starting..."
  service shibd stop || true
  service shibd start
else
  echo "[11.shibd.sh] no shibd found..."
fi

true
