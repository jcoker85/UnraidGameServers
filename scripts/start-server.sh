#!/bin/bash
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
        +force_install_dir ${SERVER_DIR} \
        +login anonymous \
        +app_update ${GAME_ID} validate \
        +quit
    else
        ${STEAMCMD_DIR}/steamcmd.sh \
        +force_install_dir ${SERVER_DIR} \
        +login anonymous \
        +app_update ${GAME_ID} \
        +quit
    fi
else
    if [ "${VALIDATE}" == "true" ]; then
    	echo "---Validating installation---"
        ${STEAMCMD_DIR}/steamcmd.sh \
        +force_install_dir ${SERVER_DIR} \
        +login ${USERNAME} ${PASSWRD} \
        +app_update ${GAME_ID} validate \
        +quit
    else
        ${STEAMCMD_DIR}/steamcmd.sh \
        +force_install_dir ${SERVER_DIR} \
        +login ${USERNAME} ${PASSWRD} \
        +app_update ${GAME_ID} \
        +quit
    fi
fi

echo "---Modify default configuration with env vars---"
cd ${SERVER_DIR}
echo $(cat default-config.json | jq ".bindPort=${GAME_PORT}") > default-config.json
echo $(cat default-config.json | jq ".publicPort=${GAME_PORT}") > default-config.json
echo $(cat default-config.json | jq ".a2s.port=${A2S_PORT}") > default-config.json
echo $(cat default-config.json | jq ".rcon.port=${RCON_PORT}") > default-config.json
echo $(cat default-config.json | jq ".rcon.password=\"${RCON_PASSWORD}\"") > default-config.json
echo $(cat default-config.json | jq ".game.name=\"${GAME_NAME}\"") > default-config.json
echo $(cat default-config.json | jq ".game.password=\"${GAME_PASSWORD}\"") > default-config.json
echo $(cat default-config.json | jq ".game.passwordAdmin=\"${GAME_PASSWORD_ADMIN}\"") > default-config.json
echo $(cat default-config.json | jq ".game.scenarioId=\"${GAME_SCENARIO_ID}\"") > default-config.json
echo $(cat default-config.json | jq ".game.maxPlayers=${GAME_MAX_PLAYERS}") > default-config.json
echo "---Start Server---"
./ArmaReforgerServer -config ${SERVER_DIR}/default-config.json -profile ${PROFILE_DIR} -maxFPS ${MAX_FPS} ${GAME_PARAMS}