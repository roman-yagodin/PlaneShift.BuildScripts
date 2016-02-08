#!/bin/bash

cd $(dirname $0)
source ps-params.sh

# required packages (Debian Jessie, LMDE 2 "Betsy")
sudo apt-get --assume-yes install \
    build-essential \
    autoconf \
    libtool \
    jam \
    bison \
    flex-old \
    subversion \
    libmng-dev \
    libpng12-dev \
    libjpeg-dev \
    x11proto-gl-dev \
    libogg-dev \
    libvorbis-dev \
    libcurl4-openssl-dev \
    libmikmod2-dev \
    zlibc \
    zlib1g-dev \
    nvidia-cg-toolkit \
    libglu1-mesa-dev \
    xserver-xorg-dev \
    libxt-dev \
    libasound2-dev \
    alsa-oss \
    libopenal1 \
    libopenal-dev \
    libspeex-dev \
    libfreetype6 \
    libfreetype6-dev \
    libxxf86vm-dev \
    libxext-dev \
    x11proto-xext-dev \
    libxcursor-dev \
    libhunspell-dev \
    libsqlite3-dev \
    libmysqlclient-dev
