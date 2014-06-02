# About

This is collection of scripts to automate building process of [PlaneShift](http://www.planeshift.it) 3D fantasy MMORPG client
on latest [Linux Mint Debian Editon](http://www.linuxmint.com/download_lmde.php) (LMDE). I hope with very small adjustments it should work on other Debian distributives / derivatives.

# Why build?

PlaneShift team provides [static client for Linux](http://www.planeshift.it/Download), both x86 and x86_64 platforms, but making self-made client provides some advantages:

* Somethat higher FPS / smoother gameplay that with static client
* Ability to test recent code changes (and also encounter recently added bugs)
* Ability to use community-provided code patches that enhances some game aspects
* Ability to test your own patches before committing them to the project team

# Using scripts

## Download and configure

Download build scripts [release package](https://github.com/roman-yagodin/PlaneShift.BuildScripts/releases) and unpack it. Then open `ps-params.sh` and modify environment variables by your preference:

* First of, you should set PS_BUILD variable to development directory - there all sources will be downloaded, 
compiled and installed locally. 

* Build scripts assume that you have latest PS client release installed to get art and some data from install,
so second important thing is to specify this location in PS_RELEASE variable. 

* Third important variable is GCC_NEW, which must be set to newest gcc/g++ (GNU C/C++ compiler) version installed on your machine.

```Shell
# path to the development directory
PS_BUILD="$HOME/build/planeshift"

# path to installed PS release
PS_RELEASE="$HOME/opt/PlaneShift"

# Cal3D revision number
CAL3D_REVISION=507

# CrystalSpace 3D revision number
CS_REVISION=38934

# "Old" gcc version - for building CS, leave 4.6
GCC_OLD=4.6

# "New" gcc version - your system's latest gcc version 
GCC_NEW=4.8
```

## Prepare for build

Run ./ps-prereq-lmde.sh to install required packages, get source code from repositories and setup build environment.
This one takes some time and traffic. Script asks for superuser privilegies to install required packages and setup gcc alternative.

## Build required libraries

Run following script to build Bullet, Cal3D and then CrystalSpace 3D:

1. ./ps-build-bullet.sh
2. ./ps-build-cal3d.sh [-u]
3. ./ps-build-cs.sh [-u]

If optional <code>-u</code> switch specified, script updates source from repository, discarding all changes made in local files. 
If you encounter problems on any step, you should fix them before going further. 

Building CS require gcc 4.6, so ps-build-cs.sh script asks for superuser privilegies to switch gcc alternatives.

## Build client

To build client, disabling breakpad before, run ps-build-client.sh [-u]

## Setup client

Run ./ps-setup-client.sh

This makes art directory with hardlinks to release art, copies servers.xml and emotes.xml from release data, 
points to CS plugins in vfs.cfg, creates start script in PS_BUILD directory 
and makes desktop shortcut in ~/.local/share/applications to run the client.

## Run game

Run ./psclient.sh or use shortcut named "PlaneShift (compiled)" in the applications menu.

# Upgrade client to newest version

Just run: 

```Shell
./ps-build-client.sh -u 
./ps-setup-client.sh
```

# TODO

* Support appliyng patches from specified folder;
* Support building and setting up both client and server;
* Add support for various Linux distributions.

# Contributions

Please let me know if these scripts are working (or not working) in your environment - 
[add new issue](https://github.com/roman-yagodin/PlaneShift.BuildScripts/issues) using this project's issue tracker, describe your build environment, build errors, etc.
