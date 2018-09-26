#!/bin/bash
set -e

BOT_TOKEN=$1

sed -i -e "s/BOT_TOKEN/${BOT_TOKEN}/g" config.json

cat config.json

bash craig.sh

