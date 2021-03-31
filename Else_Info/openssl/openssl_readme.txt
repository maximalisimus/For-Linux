

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
openssl req -new -key server.key -out server.csr -config ./openssl.conf
openssl x509 -req -in server.csr -CA IntermediateCA.crt -CAkey IntermediateCA.key -set_serial 01 -out server.crt -days 500 -sha1

echo 'verification of sort here'
openssl x509 -in server.crt -noout -text |grep 'host.localism'


#optional​, not going over.
#echo​ 'for the sake of windows clients, we created a pkcs file, but lets create usable PEMs'
#openssl​ pkcs12 -export -out IntermediateCA.pkcs -inkey ia.key -in IntermediateCA.crt -chain -CAfile ca.crt
#openssl​ pkcs12 -in path.p12 -out newfile.crt.pem -clcerts -nokeys
#openssl​ pkcs12 -in path.p12 -out newfile.key.pem -nocerts -nodes

openssl s_client -connect 192.168.0.17:443

nano openssl.conf
[ req ]
default_md         = sha1
prompt             = no
distinguished_name = req_distinguished_name
req_extensions     = v3_req

[ req_distinguished_name ]
countryName            = "RU"                    	   # C=
stateOrProvinceName    = "Europe Moscow"          	   # ST=
localityName           = "Redacted"                	   # L=
organizationName       = "Warden"	            	   # O=
organizationalUnitName = "HomeLab"                	   # OU=
commonName             = "warden.vps.com"        	   # CN=
emailAddress           = "maximalisimus127@gmail.com"  # CN/emailAddress=

[ v3_req ]
subjectAltName  = DNS:warden.vps.com # multidomain certificate










# OpenSSL configuration to generate a new key with signing requst for a x509v3 
# multidomain certificate
#
# openssl req -config bla.cnf -new | tee csr.pem
# or
# openssl req -config bla.cnf -new -out csr.pem
[ req ]
default_bits       = 4096
default_md         = sha512
default_keyfile    = key.pem
prompt             = no
encrypt_key        = no

# base request
distinguished_name = req_distinguished_name

# extensions
req_extensions     = v3_req

# distinguished_name
[ req_distinguished_name ]
countryName            = "DE"                     # C=
stateOrProvinceName    = "Hessen"                 # ST=
localityName           = "Keller"                 # L=
postalCode             = "424242"                 # L/postalcode=
streetAddress          = "Crater 1621"            # L/street=
organizationName       = "apfelboymschule"        # O=
organizationalUnitName = "IT Department"          # OU=
commonName             = "example.com"            # CN=
emailAddress           = "webmaster@example.com"  # CN/emailAddress=

# req_extensions
[ v3_req ]
# The subject alternative name extension allows various literal values to be 
# included in the configuration file
# http://www.openssl.org/docs/apps/x509v3_config.html
subjectAltName  = DNS:www.example.com,DNS:www2.example.com # multidomain certificate

# vim:ft=config






sudo a2enmod headers
sudo a2enmod ssl
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod proxy_balancer
sudo a2enmod lbmethod_byrequests

sudo systemctl restart apache2

<VirtualHost *:80>
 ProxyPreserveHost On

 ProxyPass / http://127.0.0.1:8080/
 ProxyPassReverse / http://127.0.0.1:8080/
</VirtualHost>

sudo nano /etc/apache2/sites-enabled/000-default.conf

<VirtualHost *:443>
    
    SSLEngine on
    SSLCertificateFile /etc/ssl/domain.crt
    SSLCertificateKeyFile /etc/ssl/domain.key
    SSLCACertificateFile /etc/ssl/rootCA.crt
    SSLCertificateChainFile /etc/ssl/certs/IntermediateCA.crt
    
    ProxyPreserveHost On
    ProxyPass / http://localhost:8005/
    ProxyPassReverse / http://localhost:8005/
</VirtualHost>

/usr/local/share/ca-certificates/
sudo update-ca-certificates
sudo update-ca-trust




nginx:
ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
ssl_ciphers         AES128-SHA:AES256-SHA:RC4-SHA:DES-CBC3-SHA:RC4-MD5;
ssl_certificate     /usr/local/nginx/conf/cert.pem;
ssl_certificate_key /usr/local/nginx/conf/cert.key;


listen 443;
ssl on;
ssl_certificate /etc/ssl/cert/example.crt;
ssl_certificate_key /etc/ssl/private/example.key;
ssl_protocols SSLv3 TLSv1;
ssl_ciphers ALL:!aNULL:!ADH:!eNULL:!LOW:!EXP:RC4+RSA:+HIGH:+MEDIUM;
server_name example.com www.example.com;



server {
    listen       443;
    server_name  _;

    ssl                  on;
    ssl_certificate      cert.pem;
    ssl_certificate_key  cert.key;

    ssl_session_timeout  5m;

    ssl_protocols  SSLv2 SSLv3 TLSv1;
    ssl_ciphers  ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv2:+EXP;
    ssl_prefer_server_ciphers   on;

    ssl_client_certificate ca.pem;
    ssl_verify_client on;
    ssl_verify_depth 1;

    location / {
        root   html;
        index  index.html index.htm;
    }
}

cp intermediate.crt ca.pem
cat root.crt >> ca.pem

openssl verify -CAfile /etc/nginx/ca.pem certs/client.crt 
certs/client.crt: OK



