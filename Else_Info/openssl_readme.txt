

===== Task: =====
Generate a certificate chain with a private Certificate Authority.

===== Condition: =====
Given one Linux machine with root access (for trust), with openssl, potentially apache/nginx

===== Standard: =====
Have the certificate be trusted by the machine.

==== Steps: ====
1. Generate Root key
2. Generate Root certificate
3. Generate Intermediate Certificate Authority key
4. Create Intermediate Certificate Signing Request (CSR)
5. Generate Intermediate Certificate signed by Root CA
6. Add certificates to Operating system's trust (Debian/deb-ish)
7. Generate RSA server key
8. Create server certificate signing request, to be signed by intermediate
9. Sign CSR, by intermediate CA
10. Verify everything
11. Webserver
12. verify again!

==== commands ====
openssl genrsa -out RootCA.key 4096
openssl req -new -x509 -days 1826 -key RootCA.key -out RootCA.crt

echo 'Root Certificate done, now intermediate begins'
openssl genrsa -out IntermediateCA.key 4096
openssl req -new -key IntermediateCA.key -out IntermediateCA.csr
openssl x509 -req -days 1000 -in IntermediateCA.csr -CA RootCA.crt -CAkey RootCA.key -CAcreateserial  -out IntermediateCA.crt

echo 'intermediate done, now on to importing cert into the OS trust'
cp *.crt /usr/local/share/ca-certificates/
update-ca-certificates

echo 'now for the server specific material'
openssl genrsa -out server.key 2048
OPENSSL_CONF=~/openssl.conf openssl req -new -key server.key -out server.csr
openssl x509 -req -in server.csr -CA IntermediateCA.crt -CAkey IntermediateCA.key -set_serial 01 -out server.crt -days 500 -sha1

echo 'verification of sort here'
openssl x509 -in server.crt -noout -text |grep 'host.localism'


#optional​, not going over.
#echo​ 'for the sake of windows clients, we created a pkcs file, but lets create usable PEMs'
#openssl​ pkcs12 -export -out IntermediateCA.pkcs -inkey ia.key -in IntermediateCA.crt -chain -CAfile ca.crt
#openssl​ pkcs12 -in path.p12 -out newfile.crt.pem -clcerts -nokeys
#openssl​ pkcs12 -in path.p12 -out newfile.key.pem -nocerts -nodes

openssl s_client -connect 192.168.0.17:443

contents OPENSSL.conf
[req]
prompt = no
default_md = sha1 #for​ video use only, sha256 onwards
req_extensions = req_ext
distinguished_name = dn

[ dn ]
C=US
ST=North Carolina
O=LazyTree
localityName=Redacted
OU=HomeLab
emailAddress=kondor6c@lazytree.us
CN=www.lazytree.us


