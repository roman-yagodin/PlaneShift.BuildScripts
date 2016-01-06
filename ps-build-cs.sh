#!/bin/bash

cd $(dirname $0)
source ps-params.sh

# clean
cd "$PS_BUILD/cs"
jam clean

# update
if [ "$1" = "-u" ]
then
	svn update -r $CS_REVISION

	# apply rev. 39918 changes to CS:
	# http://sourceforge.net/p/crystal/code/39918/tree//CS/trunk/include/csutil/csuctransform.h?diff=50bef7385fcbc92b9bac5b34:39917
	sed -i 's/if ((srcSize == 0) || (source == 0))/if (source == 0)/' ./include/csutil/csuctransform.h
fi

# point to Cal3D and Bullet
export LD_LIBRARY_PATH="$PS_BUILD/cal3d/src/cal3d/.libs/:$PS_BUILD/bullet/lib/:$LD_LIBRARY_PATH"

# get current gcc version (assume it's the latest gcc version available)
GCC_VERSION=$(gcc --version | grep ^gcc | sed 's/^.* //g')
GCC_VERSION=${GCC_VERSION:0:3}

if [ "$GCC_VERSION" = "4.7" ]
then
	# install gcc 4.6, needed to build CrystalSpace 3D
	sudo apt-get --assume-yes install gcc-4.6 g++-4.6

	# setup gcc alternatives
	sudo update-alternatives --remove-all gcc
	sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.6 40 --slave /usr/bin/g++ g++ /usr/bin/g++-4.6
	sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.8

	# use gcc 4.6 for CrystalSpace 3D
	echo '1' > ~choice.txt
	sudo update-alternatives --config gcc < ~choice.txt
	rm -f ~choice.txt
fi

# build
cd "$PS_BUILD/cs"
./configure --enable-make-emulation="no" --without-wx --without-java --without-perl --without-python --without-3ds --with-cal3d="$PS_BUILD/cal3d" --with-bullet="$PS_BUILD/bullet" --prefix="$PS_BUILD/cs"
# --enable-make-emulation="no": use only Jamfiles (fix configuration)
# --without-wx: build w/o wxWidgets (build failed as wxWidgets upgraded to 3.0 in Debian Jessie)

jam -j$CONCURRENT_JOBS -aq libs plugins cs-config # walktest

if [ "$GCC_VERSION" = "4.7" ]
then
	# use default (new) gcc for the rest
	echo '0' > ~choice.txt
	sudo update-alternatives --config gcc < ~choice.txt
	rm -f ~choice.txt

	# remove gcc alternatives
	sudo update-alternatives --remove-all gcc
fi
