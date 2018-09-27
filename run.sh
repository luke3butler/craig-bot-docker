#!/bin/bash
set -e

BOT_TOKEN=$1
NICK=$2
URL=$3
DLURL=$4

echo PARAMS $*

sed -i -e "s/BOT_TOKEN/${BOT_TOKEN}/g" config.json
sed -i -e "s/NICK/${NICK}/g" config.json
sed -i -e "s/HOME_URL/${URL}/g" config.json
sed -i -e "s/DL_URL/${DLURL}/g" config.json

cat config.json
cat craig/default-config.js

if [ ! -d rec ]; then
	mkdir rec
fi

rm -r /var/www/html
mv /opt/build/craig/web /var/www/html

/etc/init.d/apache2 start

node craig-runner.js

