#!/bin/sh
cp /etc/letsencrypt/live/my.fqdn.com/* /usr/local/freeswitch/certs/
cd /usr/local/freeswitch/certs/
cat fullchain.pem privkey.pem > wss.pem
cat cert.pem privkey.pem > agent.pem
cat chain.pem > cafile.pem
