# About

This is collection of scripts to automate building process of [PlaneShift](http://www.planeshift.it) 3D fantasy MMORPG client
on latest [Linux Mint Debian Editon](http://www.linuxmint.com/download_lmde.php) (LMDE). I hope with very small adjustments it should work on other Debian distributions / derivatives and Linux in common.

# Why build?

PlaneShift team provides [static client for Linux](http://www.planeshift.it/Download), both x86 and x86_64 platforms, but making self-made client provides some advantages:

* Somethat higher FPS / smoother gameplay that with static client
* Ability to test recent code changes (and also encounter recently added bugs)
* Ability to use community-provided code patches that enhance some game aspects (like [this one](http://greatshift.111mb.de/psextended))
* Ability to test your own patches before committing them to the project team

# Using scripts

## General notice

If you encounter problems on any step, you should fix them before going further.

## Download and configure

Download build scripts [release package](https://github.com/roman-yagodin/PlaneShift.BuildScripts/releases) and unpack it. Check that all *.sh files have executable permission. Then open `ps-params.sh` in the text editor and modify environment variables by your preference:

* First of, you should set PS_BUILD variable to development directory - there all sources will be downloaded, 
compiled and installed locally. 

* Build scripts assume that you have latest PS client release installed to get art and some data from install,
so second important thing is to specify this location in PS_RELEASE variable. 

Make sure that PS_BUILD path doesn't contains spaces - Cal3D, CrystalSpace, PlaneShift are fine with this, but Bullet won't install.

```shell
# path to the development directory
PS_BUILD="$HOME/build/planeshift"

# path to installed PS release
PS_RELEASE="$HOME/opt/PlaneShift"

# Cal3D revision number
CAL3D_REVISION=507

# CrystalSpace 3D revision number
CS_REVISION=38934

# PlaneShift revision number (empty = trunk)
PS_REVISION=""

# Number of concurrent build jobs
CONCURRENT_JOBS=3
```
## Optimistic way

Just run `./ps-optimistic.sh` and cross the fingers :)

## Less optimistic way

Run following scripts to install required packages, get source code from repositories and setup build environment.
This takes some time and traffic, so be patient. Script `./ps-prereq-lmde.sh` asks for superuser privilegies to install packages.

* `./ps-prereq-lmde.sh` 
* `./ps-update-all.sh`

## Build required libraries

Run following script to build Bullet and Cal3D:

* `./ps-build-bullet.sh`
* `./ps-build-cal3d.sh [-u]`

If optional `-u` switch specified, script updates source from repository, discarding all changes made in local files. 

Then you should build CrystalSpace 3D engine:

* `./ps-build-cs.sh [-u]`

Crystal Space 3D have known build problems with gcc 4.7 (but not gcc 4.6 or 4.8). So if you are using gcc 4.7, then script installs gcc 4.6 
and use it for building CS (this will reqiure superuser privileges).

## Build client

To build client, run `./ps-build-client.sh [-u]`

## Setup client

Run `./ps-setup-client.sh`

This makes `art` directory with hardlinks to release art, copies `servers.xml` and `emotes.xml` from release data, 
creates startup script in PS_BUILD directory and makes desktop shortcut in `~/.local/share/applications` to run the client.

## Run game

Run `./psclient.sh` or use shortcut named "PlaneShift (compiled)" in the applications menu.

# Upgrade client to latest version

Just run: 

```shell
./ps-build-client.sh -u 
./ps-setup-client.sh
```

# TODO

* Support appliyng patches from specified folder
* Support building and setting up both client and server
* Add support for various Linux distributions

# Contributions

Please let me know if these scripts are working (or not working) in your environment - 
[add new issue](https://github.com/roman-yagodin/PlaneShift.BuildScripts/issues) using this project's issue tracker, describe your build environment, build errors, etc.
