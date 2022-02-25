  GNU nano 4.8                      cert2.sh
#!/bin/bash

# 720h = 30 дней
# 8760h = 1 год
# 43800h = 5 лет
# cert: 87600h = 10 лет
# int: 175200h = 20 лет
# root: 262800h = 30 лет
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root

# enable Vault PKI secret
vault secrets enable pki
vault secrets tune -max-lease-ttl=87600h pki




# generate root CA
vault write -field=certificate pki/root/generate/internal \
     common_name="example.com" \
     ttl=87600h > CA_cert.crt

# publish urls for the root ca
vault write pki/config/urls \
     issuing_certificates="$VAULT_ADDR/v1/pki/ca" \
     crl_distribution_points="$VAULT_ADDR/v1/pki/crl"
# enable Vault PKI secret
vault secrets enable -path=pki_int pki

vault secrets tune -max-lease-ttl=43800h pki_int
# create intermediate CA with common name example.com and save the CSR
vault write -format=json pki_int/intermediate/generate/internal \
     common_name="example.com Intermediate Authority" \
     | jq -r '.data.csr' > pki_intermediate.csr
# send the intermediate CA's CSR to the root CA
vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr>
     format=pem_bundle ttl="43800h" \
     | jq -r '.data.certificate' > intermediate.cert.pem

# publish the signed certificate back to the Intermediate CA
vault write pki_int/intermediate/set-signed certificate=@intermediate.cert.>

# create a role example-dot-com
vault write pki_int/roles/example-dot-com \
     allowed_domains="example.com" \
     allow_subdomains=true \
     max_ttl="720h"

# Create cert
vault write -format=json pki_int/issue/example-dot-com \
  common_name="vault.example.com" \
  alt_names="vault.example.com" \
  ttl="720h" > vault.example.com.crt

# save cert
cat vault.example.com.crt | jq -r .data.certificate > vault.example.com.crt>
cat vault.example.com.crt | jq -r .data.issuing_ca >> vault.example.com.crt>
cat vault.example.com.crt | jq -r .data.private_key > vault.example.com.crt>
cp  vault.example.com.crt.pem /etc/ssl/certs/localhost.pem
cp  vault.example.com.crt.key /etc/ssl/private/localhost.key
cp CA_cert.crt /usr/local/share/ca-certificates/CA_cert.crt
update-ca-certificates
systemctl restart nginx.service

pgrep -f vault | xargs kill


