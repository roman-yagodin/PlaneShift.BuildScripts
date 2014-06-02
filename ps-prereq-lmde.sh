#!/bin/bash

cd $(dirname $0)
source ps-params.sh

# required packages (LMDE)
sudo apt-get --assume-yes install libjpeg8-dev x11proto-gl-dev autoconf jam bison flex-old automake1.9 automake1.11 libcurl4-openssl-dev libmng-dev libmikmod2-dev libogg-dev libvorbis-dev zlib1g-dev libpng12-dev build-essential libtool libglu1-mesa-dev xserver-xorg-dev libxt-dev libopenal1 libopenal-dev subversion zlibc libfreetype6-dev libfreetype6 libasound2-dev alsa-oss libxxf86vm-dev libxext-dev x11proto-xext-dev libspeex-dev libxcursor-dev nvidia-cg-toolkit libhunspell-dev libsqlite3-dev libmysqlclient-dev # libbullet-dev libbulletml-dev

# install "old" gcc (4.6, needed to build CrystalSpace 3D) and setup alternatives
sudo apt-get --assume-yes install gcc-$GCC_OLD g++-$GCC_OLD
sudo update-alternatives --remove-all gcc
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-$GCC_OLD 40 --slave /usr/bin/g++ g++ /usr/bin/g++-$GCC_OLD 
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-$GCC_NEW 60 --slave /usr/bin/g++ g++ /usr/bin/g++-$GCC_NEW

# create build directory
mkdir -p $PS_BUILD
cd $PS_BUILD

# get Bullet
wget https://bullet.googlecode.com/files/bullet-2.80-rev2531.tgz
tar -zxf bullet-2.80-rev2531.tgz
mv -f bullet-2.80-rev2531 bullet
rm -f bullet-2.80-rev2531.tgz

# get Cal3D
svn co -r $CAL3D_REVISION svn://svn.gna.org/svn/cal3d/trunk/cal3d cal3d

# get CrystalSpace 3D
svn co -r $CS_REVISION http://svn.code.sf.net/p/crystal/code/CS/trunk cs

# get PlaneShift
svn co https://planeshift.svn.sourceforge.net/svnroot/planeshift/trunk planeshift

