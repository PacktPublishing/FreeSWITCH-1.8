#!/bin/sh
mkdir -p /usr/local/freeswitch/bin
ln -s /usr/bin/freeswitch /usr/local/freeswitch/bin/
ln -s /usr/bin/fs_* /usr/local/freeswitch/bin/
ln -s /usr/bin/fsxs /usr/local/freeswitch/bin/
ln -s /usr/bin/tone2wav /usr/local/freeswitch/bin/
ln -s /usr/bin/gentls_cert /usr/local/freeswitch/bin/
ln -s /etc/freeswitch /usr/local/freeswitch/conf
ln -s /var/lib/freeswitch/* /usr/local/freeswitch/
ln -s /var/log/freeswitch /usr/local/freeswitch/log
ln -s /var/run/freeswitch /usr/local/freeswitch/run
ln -s /etc/freeswitch/tls /usr/local/freeswitch/certs
ln -s /usr/lib/freeswitch/mod /usr/local/freeswitch/
rm /usr/local/freeswitch/lang
