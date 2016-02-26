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

# Lets define some vars to simplify our life
user="steam"
steamcmd="/home/$user/steamcmd/"
gamedir="/home/$user/gamedir/"
filehash=""
steamcmdhash="09e3f75c1ab5a501945c8c8b10c7f50e"


# We need 32bits paquets for SteamCMD
if [[ "getconf LONG_BIT" == '64' ]]; then
    dpkg --add-architecture i386 && apt-get update && apt-get install -y ia32-libs ia32-libs-gtk
fi

# Lets create a user "steam" with no passwd and no shell
id -u ${user} &>/dev/null || useradd -r -m ${user}
su ${user} -c "mkdir ${steamcmd} && mkdir ${gamedir}"

# Time to install SteamCMD
su ${user} -c "cd ${steamcmd} && rm steamcmd_linux.tar.gz* && wget http://media.steampowered.com/client/steamcmd_linux.tar.gz"
if [[ "$?" != 0 ]]; then
    echo "[ERROR] An error happend during the download."
    exit 1
fi
#TODO : implement a md5 check
su ${user} -c "cd ${steamcmd} && tar -xvzf steamcmd_linux.tar.gz"
filehash=$(md5sum steamcmd_linux.tar.gz | cut -d' ' -f1)
if test ${filehash} == ${steamcmdhash} 
then
  echo "[OK] md5 validation is good, continuing"
else
  echo "[ERROR] Invalide md5 : " ${chkhash}
  exit
fi

# Let's purge some unsued files
su $user -c "cd $steamcmd && rm steamcmd_linux.tar.gz*"

# And to run it one time to check updates
su $user -c "cd $steamcmd && ./steamcmd.sh +quit"

# That's all (folks)
