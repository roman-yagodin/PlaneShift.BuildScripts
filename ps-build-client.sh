#!/bin/bash

cd $(dirname $0)
source ps-params.sh

export LD_LIBRARY_PATH="$PS_BUILD/cal3d/src/cal3d/.libs/:$PS_BUILD/bullet/lib/:$LD_LIBRARY_PATH"
export CRYSTAL="$PS_BUILD/cs"

# clean
cd "$PS_BUILD/planeshift"
jam clean

# update
if [ "$1" = "-u" ]
then
	cd "$PS_BUILD/planeshift"
	svn update	
	
	# disable breakpad
	sed -i 's/#define\ USE_BREAKPAD/\/\/ #define\ USE_BREAKPAD/' src/client/crashreport.cpp

	# point to CS plugins in vfs.cfg
	CS_CONFIG=$(echo "${PS_BUILD:${#HOME}}/cs/data/config/plugins/" | sed -r 's/\//\\\$\\\//g')
	sed -i "s/VFS.Mount.config = \$@data\$\/config-plugins\$\//\0,$CS_CONFIG/" "$PS_BUILD/planeshift/vfs.cfg"
fi

# build
cd "$PS_BUILD/planeshift"
./autogen.sh 
./configure --with-cal3d="$PS_BUILD/cal3d"
jam -j$CONCURRENT_JOBS -aq client

# client and extra tools: jam -a

