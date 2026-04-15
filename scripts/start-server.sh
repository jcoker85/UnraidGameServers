#!/bin/bash
export DISPLAY=:99
if [ ! -f ${STEAMCMD_DIR}/steamcmd.sh ]; then
    echo "SteamCMD not found!"
    wget -q -O ${STEAMCMD_DIR}/steamcmd_linux.tar.gz http://media.steampowered.com/client/steamcmd_linux.tar.gz 
    tar --directory ${STEAMCMD_DIR} -xvzf /serverdata/steamcmd/steamcmd_linux.tar.gz
    rm ${STEAMCMD_DIR}/steamcmd_linux.tar.gz
fi

echo "---Update SteamCMD---"
if [ "${USERNAME}" == "" ]; then
    ${STEAMCMD_DIR}/steamcmd.sh \
    +login anonymous \
    +quit
else
    ${STEAMCMD_DIR}/steamcmd.sh \
    +login ${USERNAME} ${PASSWRD} \
    +quit
fi

echo "---Update Server---"
if [ "${USERNAME}" == "" ]; then
    if [ "${VALIDATE}" == "true" ]; then
    	echo "---Validating installation---"
        ${STEAMCMD_DIR}/steamcmd.sh \
        +@sSteamCmdForcePlatformType windows \
        +force_install_dir ${SERVER_DIR} \
        +login anonymous \
        +app_update ${GAME_ID} validate \
        +quit
    else
        ${STEAMCMD_DIR}/steamcmd.sh \
        +@sSteamCmdForcePlatformType windows \
        +force_install_dir ${SERVER_DIR} \
        +login anonymous \
        +app_update ${GAME_ID} \
        +quit
    fi
else
    if [ "${VALIDATE}" == "true" ]; then
    	echo "---Validating installation---"
        ${STEAMCMD_DIR}/steamcmd.sh \
        +@sSteamCmdForcePlatformType windows \
        +force_install_dir ${SERVER_DIR} \
        +login ${USERNAME} ${PASSWRD} \
        +app_update ${GAME_ID} validate \
        +quit
    else
        ${STEAMCMD_DIR}/steamcmd.sh \
        +@sSteamCmdForcePlatformType windows \
        +force_install_dir ${SERVER_DIR} \
        +login ${USERNAME} ${PASSWRD} \
        +app_update ${GAME_ID} \
        +quit
    fi
fi

echo "---Prepare Server---"
export WINEARCH=win64
export WINEPREFIX=/serverdata/serverfiles/WINE64
echo "---Checking if WINE workdirectory is present---"
if [ ! -d ${SERVER_DIR}/WINE64 ]; then
	echo "---WINE workdirectory not found, creating please wait...---"
    mkdir ${SERVER_DIR}/WINE64
else
	echo "---WINE workdirectory found---"
fi
echo "---Checking if WINE is properly installed---"
if [ ! -d ${SERVER_DIR}/WINE64/drive_c/windows ]; then
	echo "---Setting up WINE---"
    cd ${SERVER_DIR}
    winecfg > /dev/null 2>&1
    sleep 15
    wineserver -k >/dev/null 2>&1
else
	echo "---WINE properly set up---"
fi

#echo "---Checking if runtimes are installed---"
#if [ ! -f ${SERVER_DIR}/runtimes ]; then
#  echo "---Runtimes not installed, please wait installing...---"
#  find /tmp -name ".X99*" -exec rm -f {} \; > /dev/null 2>&1
#  /opt/scripts/start-Xvfb.sh 2>/dev/null &
#  sleep 5
#  /usr/bin/winetricks -q vcrun2019 2>/dev/null
#  kill $(pidof Xvfb) 2>/dev/null
#  touch ${SERVER_DIR}/runtimes
#  echo "---Installation from runtimes finished!---"
#else
#  echo "---Runtimes found! Continuing...---"
#fi

echo "---Checking for old display lock files---"
find /tmp -name ".X99*" -exec rm -f {} \; > /dev/null 2>&1
chmod -R ${DATA_PERM} ${DATA_DIR}

#echo "---Starting Xvfb server---"
#screen -S Xvfb -d -m /opt/scripts/start-Xvfb.sh
#sleep 5
#
#echo "---Start Server---"
#cd ${SERVER_DIR}
#if [ ! -f ${SERVER_DIR}/SNMASServer.exe ]; then
#  echo "---Something went wrong, can't find the executable, putting container into sleep mode!---"
#  sleep infinity
#else
#  screen -S SNMAS -d -m wine64 ${SERVER_DIR}/SNMASServer.exe -log ${GAME_PARAMS}
#  export LATEST_LOG=$(find ${SERVER_DIR}/SNM2020/Saved/Logs/ -type f -name "SnMDedSrv*" -exec ls -t1 {} + | tail -n+1 | head -1)
#  sleep 2
#  /opt/scripts/start-watchdog.sh &
#  tail -n 25 -s 10 -f ${SERVER_DIR}/SNM2020/Saved/Logs/SNM2020.log ${LATEST_LOG}
#fi

echo "---Start Server---"
cd ${SERVER_DIR}
xvfb-run --auto-servernum --server-args='-screen 0 640x480x24:32' wine64 ${SERVER_DIR}/R5/Binaries/Win64/WindroseServer-Win64-Shipping.exe -log >/dev/null 2>&1 &
sleep 5
/opt/scripts/start-watchdog.sh &
tail -n +0 -f ${SERVER_DIR}/R5/Saved/Logs/R5.log