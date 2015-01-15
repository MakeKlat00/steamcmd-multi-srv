#!/bin/bash
# SteamCMD installer
#
# Copyright 2014 A-xis & Chk
# based on Chk work: http://chikoumi.com/blog/post/installer-un-serveur-csgo
#
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# We need 32bits paquets for SteamCMD
if [ "getconf LONG_BIT" = '64' ]; then
    dpkg --add-architecture i386 && apt-get update && apt-get install -y ia32-libs ia32-libs-gtk
fi

# Lets create a user "steam" with no passwd and no shell
useradd -r -m steam
su steam -c "mkdir home/steam/steamcmd/ && mkdir /home/steam/gameserver/"

# Time to install SteamCMD
su steam -c "cd /home/steam/steamcmd && wget http://media.steampowered.com/client/steamcmd_linux.tar.gz && tar -xvzf steamcmd_linux.tar.gz"
#TODO : implement a md5 check

# And to run it one time to check updates
su steam -c "cd /home/steam/steamcmd && ./steamcmd.sh +quit"
