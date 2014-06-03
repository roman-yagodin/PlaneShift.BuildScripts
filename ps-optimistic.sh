#!/bin/bash

cd $(dirname $0)
source ps-params.sh

# install packages
./ps-prereq-lmde.sh

# get sources
./ps-update-all.sh

# build all
./ps-build-bullet.sh
./ps-build-cal3d.sh
./ps-build-cs.sh
./ps-build-client.sh

# setup client
./ps-setup-client.sh

# run client
$PS_BUILD/psclient.sh

