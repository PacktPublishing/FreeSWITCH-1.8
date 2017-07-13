#!/bin/sh
cd /usr/src
git config --global url."https://".insteadOf git://
git clone https://freeswitch.org/stash/scm/fs/freeswitch.git -bv1.6 freeswitch
cd /usr/src/freeswitch/html5/verto/verto_communicator/
./debian8-install.sh
ln -s /usr/src/freeswitch/html5/verto/verto_communicator/dist /var/www/html/vc
