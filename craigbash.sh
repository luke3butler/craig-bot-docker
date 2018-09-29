#!/bin/bash

cont=$(docker ps | awk -S '{ print $1; }' | grep -v CONT)
echo Container ${cont}

docker exec -it ${cont} $*
