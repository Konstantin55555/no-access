#!/bin/bash
source keycloak-login.sh

CLIENT=account-console

CLIENT=account

REALMS=("${INXMAIL_REALM}" "${NXP_REALM}" "${LOGIN_REALM}")
for i in "${!REALMS[@]}"; do
  echo "Create client ${CLIENT} in realm ${REALMS[i]}"
  CLIENT_MODEL_ID=`${KCADM} create clients -r "${REALMS[i]}" -s clientId="${CLIENT}" -s name='${client_account-console}' -s enabled=true -s fullScopeAllowed=false -s publicClient=true -s directAccessGrantsEnabled=false -s rootUrl='${authBaseUrl}' -s baseUrl="/realms/${REALMS[i]}/account/" -s "redirectUris=[\"/realms/${REALMS[i]}/account/*\"]" --id`
  ${KCADM} create clients/${CLIENT_MODEL_ID}/protocol-mappers/models -r ${REALMS[i]} -s name='audience resolve' -s protocol=openid-connect -s protocolMapper=oidc-audience-resolve-mapper 
done