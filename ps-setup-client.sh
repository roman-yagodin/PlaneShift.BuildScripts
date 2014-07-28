#!/bin/bash

cd $(dirname $0)
source ps-params.sh

# make hard links to released art files
rm -fR "$PS_BUILD/planeshift/art"
cp -fal "$PS_RELEASE/art" "$PS_BUILD/planeshift"

# NOTE: if you modify files in $PS_BUILD/planeshift/art, 
# they do *not* change in $PS_RELEASE/art as they copied on write 

# update data directory from release, leaving existing files as is
cp -frn "$PS_RELEASE/data" "$PS_BUILD/planeshift"

# copy list of servers from release
cp -f "$PS_RELEASE/data/servers.xml" "$PS_BUILD/planeshift/data"

# copy emotes from release
cp -f "$PS_RELEASE/data/emotes.xml" "$PS_BUILD/planeshift/data"

# make launch script
PS_START_SCRIPT="$PS_BUILD/psclient.sh"

echo "#!/bin/bash" > $PS_START_SCRIPT
echo >> $PS_START_SCRIPT
echo "export LD_LIBRARY_PATH=\"$PS_BUILD/cal3d/src/cal3d/.libs/:$PS_BUILD/cs/:\$LD_LIBRARY_PATH\"" >> $PS_START_SCRIPT
echo "export CRYSTAL=\"$PS_BUILD/cs\"" >> $PS_START_SCRIPT
echo "cd \"$PS_BUILD/planeshift\"" >> $PS_START_SCRIPT
echo "./psclient \$@" >> $PS_START_SCRIPT
chmod a+x $PS_START_SCRIPT

# copy icons
cp -f "$PS_BUILD/icons/psicon-red.png" "$PS_BUILD/planeshift/support/icons"
cp -f "$PS_BUILD/icons/psicon-green.png" "$PS_BUILD/planeshift/support/icons"

# make desktop shortcut in ~/.local/share/applications
PS_DESKTOP_FILE=planeshift-compiled.desktop
cd "$HOME/.local/share/applications"

echo "[Desktop Entry]" > $PS_DESKTOP_FILE
echo "Encoding=UTF-8" >> $PS_DESKTOP_FILE
echo "Version=1.0" >> $PS_DESKTOP_FILE
echo "Type=Application" >> $PS_DESKTOP_FILE
echo "Exec=$PS_BUILD/psclient.sh" >> $PS_DESKTOP_FILE
echo "Icon=$PS_BUILD/planeshift/support/icons/psicon-red.png" >> $PS_DESKTOP_FILE
echo "Name=PlaneShift (compiled)" >> $PS_DESKTOP_FILE
echo "Comment=PlaneShift compiled client" >> $PS_DESKTOP_FILE
echo "Categories=Game;RolePlaying;" >> $PS_DESKTOP_FILE

