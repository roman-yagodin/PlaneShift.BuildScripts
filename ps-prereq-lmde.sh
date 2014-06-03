#!/bin/bash

cd $(dirname $0)
source ps-params.sh

# required packages (LMDE)
sudo apt-get --assume-yes install libjpeg8-dev x11proto-gl-dev autoconf jam bison flex-old automake1.9 automake1.11 libcurl4-openssl-dev libmng-dev libmikmod2-dev libogg-dev libvorbis-dev zlib1g-dev libpng12-dev build-essential libtool libglu1-mesa-dev xserver-xorg-dev libxt-dev libopenal1 libopenal-dev subversion zlibc libfreetype6-dev libfreetype6 libasound2-dev alsa-oss libxxf86vm-dev libxext-dev x11proto-xext-dev libspeex-dev libxcursor-dev nvidia-cg-toolkit libhunspell-dev libsqlite3-dev libmysqlclient-dev # libbullet-dev libbulletml-dev

# sudo apt-get --assume-yes install gcc-4.6 g++-4.6
