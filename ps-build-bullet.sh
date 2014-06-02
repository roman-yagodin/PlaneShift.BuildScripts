#!/bin/bash

cd $(dirname $0)
source ps-params.sh

# clean
cd $PS_BUILD/bullet
make uninstall
make clean

# build
cd $PS_BUILD/bullet
./autogen.sh
./configure --prefix=$PS_BUILD/bullet
make -j3 
make install
