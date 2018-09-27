FROM ubuntu:cosmic

ENV FFMPEG_VERSION=4.0.2

WORKDIR /opt/build

RUN apt-get update
RUN apt-get -y install curl nasm tar bzip2 make 
RUN apt-get -y install libopus-dev libopusfile-dev libogg-ocaml-dev
RUN apt-get -y install libvorbis-dev libmp3lame-dev libass-dev
RUN apt-get -y install librtmp-dev
RUN apt-get -y install npm git unzip zip
RUN apt-get -y install libsodium-dev node-gyp libtool libgcrypt20-dev
RUN apt-get -y install libtheora-dev libvpx-dev libwebp-dev libx264-dev
RUN apt-get -y install libx265-dev libssl-dev libfreetype6-dev libgnutls28-dev

RUN curl -s http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz | tar zxvf - -C .

WORKDIR /opt/build/ffmpeg-${FFMPEG_VERSION}

RUN ./configure --help
RUN ./configure \
  --enable-version3 --enable-gpl --enable-nonfree --enable-small --enable-libmp3lame --enable-libx264 --enable-libx265 --enable-libvpx --enable-libtheora --enable-libvorbis --enable-libopus --enable-libass --enable-libwebp --enable-librtmp --enable-postproc --enable-avresample --enable-libfreetype --enable-gnutls --disable-debug

RUN make
RUN make install
RUN echo make distclean

WORKDIR /opt/build
RUN curl https://bitbucket.org/Yahweasel/craig/get/529f2decdb8d.zip -o craig.zip 
RUN unzip craig.zip
RUN ln -s Yahweasel-craig-529f2decdb8d craig

WORKDIR /opt/build

RUN apt-get -y install autoconf

RUN git clone https://github.com/LiskHQ/node-sodium.git
WORKDIR /opt/build/node-sodium

RUN apt-get -y install npm
RUN pwd
RUN npm install

WORKDIR /opt/build/craig
RUN npm install bufferutil
RUN npm install node-opus
RUN npm install erlpack
RUN npm install opusscript
RUN npm install discord.js
RUN npm install sodium
#RUN rm -r node_modules
RUN pwd
#RUN ./configure
RUN npm install

COPY config.json config.json
COPY run.sh run.sh

ENTRYPOINT ["bash", "run.sh"]
CMD ["token", "url"]

