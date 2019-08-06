#!/usr/bin/env bash

export VAULT_ADDR='http://localhost:8200'
export VAULT_TOKEN=$(cat keys/vault-admin-token.txt)
if ! vault secrets list | grep -q concourse/; then
  vault secrets enable -path=concourse kv
else
  echo '√ vault: concourse secret engine already enabled'
fi

if ! vault list concourse/main/ | grep -q cf; then
  vault kv put concourse/main/cf api='https://api.dev.cfdev.sh' username='admin' password='admin'
else
  echo '√ vault: CF secrets already loaded'
fi

if ! vault list concourse/main/ | grep -q minio; then
  vault kv put concourse/main/minio api='http://minio:9000/' id='minio' secret='changeme'
else
  echo '√ vault: minio secrets already loaded'
fi

if ! vault list concourse/main/ | grep -q id-rsa-git; then
  vault kv put concourse/main/id-rsa-git value=@keys/git_rsa
else
  echo '√ vault: ssh key already loaded'
fi

VAULT_CLIENT_TOKEN=$(cat keys/vault-client-token.txt)
if ! vault token lookup "$VAULT_CLIENT_TOKEN" > /dev/null 2>&1; then
  vault token create -ttl 3h -id "$VAULT_CLIENT_TOKEN"
else
  echo '√ vault: client token already enabled'
fi
