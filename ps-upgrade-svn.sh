#!/bin/bash

cd $(dirname $0)
source ps-params.sh

cd "$PS_BUILD/cal3d"
svn upgrade

cd "$PS_BUILD/cs"
svn upgrade

cd "$PS_BUILD/planeshift"
svn upgrade
