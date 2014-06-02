#!/bin/bash

cd $(dirname $0)
source ps-params.sh

# clean
cd $PS_BUILD/cs
jam clean

# update
if [ "$1" = "-u" ]
then
	svn update -r $CS_REVISION
fi

# point to Cal3D and Bullet
export LD_LIBRARY_PATH=$PS_BUILD/cal3d/src/cal3d/.libs/:$PS_BUILD/bullet/lib/:$LD_LIBRARY_PATH

# use old gcc for CrystalSpace 3D
echo '1' > ~choice.txt 
sudo update-alternatives --config gcc < ~choice.txt
rm -f ~choice.txt

# build
cd $PS_BUILD/cs
./configure --without-java --without-perl --without-python --without-3ds --with-cal3d=$PS_BUILD/cal3d --with-bullet=$PS_BUILD/bullet
jam -j3 -aq libs plugins cs-config # walktest

# use "new" gcc for the rest
echo '2' > ~choice.txt 
sudo update-alternatives --config gcc < ~choice.txt
rm -f ~choice.txt

