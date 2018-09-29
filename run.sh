#!/bin/bash
set -e

BOT_TOKEN=$1
NICK=$2
URL=$3
DLURL=$4

echo PARAMS $*

sed -i -e "s~BOT_TOKEN~${BOT_TOKEN}~g" config.json
sed -i -e "s~NICK~${NICK}~g" config.json
sed -i -e "s~HOME_URL~${URL}~g" config.json
sed -i -e "s~DL_URL~${DLURL}~g" config.json

cat config.json
cat craig/default-config.js

if [ ! -d rec ]; then
	mkdir rec
fi

bash /opt/build/craig/cook/buildextras.sh

rm -r /var/www
ln -s /opt/build/craig/web /var/www
sed -e "s/user www-data/user root/g" -i /etc/nginx/nginx.conf
/etc/init.d/nginx restart 
/etc/init.d/php7.2-fpm restart

cat /var/log/nginx/*

node craig-runner.js

