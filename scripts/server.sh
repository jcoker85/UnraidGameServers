#!/bin/bash

#Thanks to ich777 for the majority of this script
if [ ! -f /servers/steamcmd/steamcmd.sh ]; then
    echo "---Installing SteamCMD---"
    wget -O /servers/steamcmd/steamcmd_linux.tar.gz http://media.steampowered.com/client/steamcmd_linux.tar.gz && \
    tar -xvzf /servers/steamcmd/steamcmd_linux.tar.gz -C /servers/steamcmd
    rm /servers/steamcmd/steamcmd_linux.tar.gz
else
  echo "---SteamCMD already installed---"
fi

if [ ! -f /servers/geserver/srcds.exe ]; then
  echo "---Installing Source SDK 2007---"
  /servers/steamcmd/steamcmd.sh +@sSteamCmdForcePlatformType windows +force_install_dir /servers/geserver +logon anonymous +app_update 310 +quit
else
  echo "---Source SDK 2007 already installed---"
fi
if [ ! -d /servers/geserver/gesource ]; then
  echo "---Installing Goldeneye Source Server---"
  7z x -y -o/servers/geserver /servers/GoldenEye_Source_v5.0.6_full_server_windows.7z
  rm /servers/GoldenEye_Source_v5.0.6_full_server_windows.7z
else
  echo "---Goldeneye Source Server already installed---"
fi

export WINEARCH=win64
export WINEPREFIX=/servers/geserver/WINE
if [ ! -d /servers/geserver/WINE ]; then
	echo "---Creating WINE prefix directory---"
    mkdir /servers/geserver/WINE
else
	echo "---WINE prefix directory already exists---"
fi
echo "---Checking WINE installation---"
if [ ! -d /servers/geserver/WINE/drive_c/windows ]; then
	echo "---Setting up WINE---"
    cd /servers/geserver
    winecfg > /dev/null 2>&1
    sleep 15
else
	echo "---WINE properly setup---"
fi
echo "---Checking for old display lock files---"
find /tmp -name ".X99*" -exec rm -f {} \; > /dev/null 2>&1
echo "---Server ready---"

echo "---Start Server---"
cd /servers/geserver
Xvfb :99 & export DISPLAY=:99
wine64 start srcds.exe -console -game gesource -port $((27015 + ${PORT_INCREMENT})) +clientport $((27005 + ${PORT_INCREMENT})) -sport $((26900 + ${PORT_INCREMENT})) +tv_port $((27020 + ${PORT_INCREMENT})) +maxplayers ${MAXPLAYERS} +map ${MAP}
tail -f /dev/null