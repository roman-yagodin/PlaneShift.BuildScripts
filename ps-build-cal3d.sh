#!/bin/bash

cd $(dirname $0)
source ps-params.sh

# clean
cd "$PS_BUILD/cal3d"
make uninstall 
make clean

# update
if [ "$1" = "-u" ]
then
	cd "$PS_BUILD/cal3d"
	svn update -r $CAL3D_REVISION
	
	# remove line with AM_USE_UNITTESTCPP from configure.in
	sed -i 's/AM_USE_UNITTESTCPP/#\ AM_USE_UNITTESTCPP/' configure.in
fi

# build
cd "$PS_BUILD/cal3d"
autoreconf --install --force
./configure --prefix="$PS_BUILD/cal3d"
make -j$CONCURRENT_JOBS
make install

