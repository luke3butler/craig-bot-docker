#!/bin/bash

sudo docker build . -t craig
sudo docker run -v /opt/craig_rec:/opt/build/craig/rec -p ${CRAIG_PORT}:80 craig ${CRAIG_TOKEN} ${CRAIG_NICK} ${CRAIG_URL} ${CRAIG_DLURL}
