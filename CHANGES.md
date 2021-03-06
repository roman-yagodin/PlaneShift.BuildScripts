# Version 0.6.4-3

* Fix CS configuration (#4) and build on Debian Jessie.
* New default prerequisites script (`ps-prereq-jessie.sh`) targeting Debian Jessie.
* Remove obsolete GCC switching steps in the CS build script (CS builds fine with GCC 4.8 and 4.9).
* Add missing starter script `psclient.sh` (referenced early in the readme).

# Version 0.6.1-3

* Use new CS revision 39798 by default + 39918 patch.
* Update data directory from the release to fix effects, etc.

# Version 0.6.1-2

* Added PS_REVISION variable to ps-params.sh (leave empty to use trunk)
* Script ps-prereq-lmde.sh now used only to install required packages
* Source code now downloaded by ps-update-all.sh script, as it looks like distro-independent
* Source code tweaks now applied in ps-update-all.sh and after update in ps-build-*.sh scripts
* Added "svn update" after "svn co" in ps-update-all.sh to allow run it several times
* Move vfs.cfg tweaks to ps-update-all.sh and ps-build-client.sh (after "svn update")
* Removed GCC_NEW and GCC_OLD variables
* Move gcc alternatives code to ps-build-cs.sh
* Script ps-build-cs.sh now determine current gcc version automatically, and if it 4.7, then installs gcc 4.6 and use it for CS
* Most paths were quoted to address issue #1, but at least Bullet and Cal3D won't install in prefix paths with spaces in any form
* Added ps-optimistic.sh script with all build steps
* Updated README.md

# Version 0.6.1-1

Initial release.
