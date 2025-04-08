#!/bin/bash

#Thanks to ich777 for the majority of this script
if [ ! -f /servers/steamcmd/steamcmd.sh ]; then
    echo "---Installing SteamCMD---"
    wget -O /servers/steamcmd/steamcmd_linux.tar.gz http://media.steampowered.com/client/steamcmd_linux.tar.gz && \
    tar -xvzf /servers/steamcmd/steamcmd_linux.tar.gz -C /servers/steamcmd && \
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
  7z x -y -o/servers/geserver /servers/GoldenEye_Source_v5.0.6_full_server_windows.7z && \
  rm /servers/GoldenEye_Source_v5.0.6_full_server_windows.7z && \
  chmod -R 770 /servers/geserver/gesource
else
  echo "---Goldeneye Source Server already installed---"
fi
if [[ "$INSTALL_MODS" == "true" ]]; then
  if [ ! -d /servers/geserver/gesource/addons/metamod ]; then
    echo "---Installing Metamod:Source---"
    wget -O /servers/geserver/gesource/metamod.zip https://mms.alliedmods.net/mmsdrop/1.12/mmsource-1.12.0-git1217-windows.zip && \
    7z x -y -o/servers/geserver/gesource/ /servers/geserver/gesource/metamod.zip  && \
    rm /servers/geserver/gesource/metamod.zip && \
    chmod -R 770 /servers/geserver/gesource/addons
  else
    echo "---Metamod:Source already installed---"
  fi
  if [ ! -d /servers/geserver/gesource/addons/sourcemod ]; then
    echo "---Installing Sourcemod---"
    wget -O /servers/geserver/gesource/sourcemod.zip https://sm.alliedmods.net/smdrop/1.12/sourcemod-1.12.0-git7196-windows.zip && \
    7z x -y -o/servers/geserver/gesource/ /servers/geserver/gesource/sourcemod.zip  && \
    rm /servers/geserver/gesource/sourcemod.zip && \
    chmod -R 770 /servers/geserver/gesource/addons && \
    chmod -R 770 /servers/geserver/gesource/cfg/sourcemod
  else
    echo "---Sourcemod already installed---"
  fi
else
  echo "---INSTALL_MODS is not set to true, so not installing Metamod:Source or Sourcemod---"
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

echo "---Copy config.vdf to enable VAC---"
mkdir -p /servers/geserver/config
mv /servers/config.vdf /servers/geserver/config/config.vdf

echo "---Start Server---"
cd /servers/geserver
Xvfb :99 & export DISPLAY=:99
wine64 start srcds.exe -console -game gesource +maxplayers ${MAXPLAYERS} +map ${MAP} ${GAME_PARAMS}
tail -f /dev/null