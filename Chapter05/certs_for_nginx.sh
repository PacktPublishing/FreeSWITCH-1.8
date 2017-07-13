#!/bin/sh
apt-get update
apt-get install nginx ca-certificates
perl -i -pe 's/# listen/listen/g' /etc/nginx/sites-enabled/default
perl -i -pe 's/# include snippets\/snakeoil.conf/include snippets\/snakeoil.conf/g' /etc/nginx/sites-enabled/default
perl -i -pe 's|/etc/ssl/certs/ssl-cert-snakeoil.pem|/usr/local/freeswitch/certs/cert.pem|g' /etc/nginx/snippets/snakeoil.conf
perl -i -pe 's|/etc/ssl/private/ssl-cert-snakeoil.key|/usr/local/freeswitch/certs/privkey.pem|g' /etc/nginx/snippets/snakeoil.conf
service nginx restart
