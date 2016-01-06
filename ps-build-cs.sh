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

# build
cd "$PS_BUILD/cs"
./configure --enable-make-emulation="no" --without-wx --without-java --without-perl --without-python --without-3ds --with-cal3d="$PS_BUILD/cal3d" --with-bullet="$PS_BUILD/bullet" --prefix="$PS_BUILD/cs"
# --enable-make-emulation="no": use only Jamfiles (fix configuration)
# --without-wx: build w/o wxWidgets (build failed as wxWidgets upgraded to 3.0 in Debian Jessie)

jam -j$CONCURRENT_JOBS -aq libs plugins cs-config # walktest
