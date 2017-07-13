#!/bin/sh
cd /usr/local/freeswitch/certs/
cp myserver.key privkey.pem
cp STAR_mydomain_com.crt cert.pem
cp STAR_mydomain_com.ca-bundle chain.pem
cat cert.pem chain.pem addtrustexternalcaroot.crt > fullchain.pem
cat cert.pem privkey.pem fullchain.pem > wss.pem
cat fullchain.pem privkey.pem > agent.pem
cat chain.pem > cafile.pem
