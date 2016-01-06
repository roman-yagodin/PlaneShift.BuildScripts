#!/bin/bash

cd $(dirname $0)
source ps-params.sh

export LD_LIBRARY_PATH="$PS_BUILD/cal3d/src/cal3d/.libs/:$PS_BUILD/cs/:$LD_LIBRARY_PATH"
export CRYSTAL="$PS_BUILD/cs"
cd "$PS_BUILD/planeshift"
./psclient $@
