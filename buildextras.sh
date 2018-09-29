#!/bin/bash

cd /opt/build/craig/cook

echo COMPILING cook >> e.log

for i in *.c; do gcc -O3 -o ${i%.c} $i; done  >> e.log
for i in *.svg; do inkscape -e ${i%.svg}.png $i; done  >> e.log

echo COOK compiled  >> e.log