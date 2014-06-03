#!/bin/bash

cd $(dirname $0)
source ps-params.sh

# create build directory
mkdir -p "$PS_BUILD"
cd "$PS_BUILD"

# get Bullet
wget https://bullet.googlecode.com/files/bullet-2.80-rev2531.tgz
tar -zxf bullet-2.80-rev2531.tgz
rm -fR bullet
mv -f bullet-2.80-rev2531 bullet
rm -f bullet-2.80-rev2531.tgz

# get Cal3D
svn co -r $CAL3D_REVISION svn://svn.gna.org/svn/cal3d/trunk/cal3d cal3d
svn update

# get CrystalSpace 3D
svn co -r $CS_REVISION http://svn.code.sf.net/p/crystal/code/CS/trunk cs
svn update

# get PlaneShift
if [ -z "$PS_REVISION" ]
then
	svn co https://planeshift.svn.sourceforge.net/svnroot/planeshift/trunk planeshift
else
	svn co -r $PS_REVISION https://planeshift.svn.sourceforge.net/svnroot/planeshift/trunk planeshift
fi
svn update

# remove line with AM_USE_UNITTESTCPP from configure.in
sed -i 's/AM_USE_UNITTESTCPP/#\ AM_USE_UNITTESTCPP/' ./cal3d/configure.in

# disable breakpad in PlaneShift client
sed -i 's/#define\ USE_BREAKPAD/\/\/ #define\ USE_BREAKPAD/' ./planeshift/src/client/crashreport.cpp

# point to CS plugins in vfs.cfg
CS_CONFIG=$(echo "${PS_BUILD:${#HOME}}/cs/data/config/plugins/" | sed -r 's/\//\\\$\\\//g')
sed -i "s/VFS.Mount.config = \$@data\$\/config-plugins\$\//\0,$CS_CONFIG/" "$PS_BUILD/planeshift/vfs.cfg"

