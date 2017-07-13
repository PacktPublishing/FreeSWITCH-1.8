#!/bin/sh
apt-get update
apt-get install apache2 ca-certificates
a2enmod ssl
a2ensite default-ssl.conf
perl -i -pe 's|/etc/ssl/certs/ssl-cert-snakeoil.pem|/usr/local/freeswitch/certs/cert.pem|g' /etc/apache2/sites-enabled/default-ssl.conf
perl -i -pe 's|/etc/ssl/private/ssl-cert-snakeoil.key|/usr/local/freeswitch/certs/privkey.pem|g' /etc/apache2/sites-enabled/default-ssl.conf
service apache2 restart
