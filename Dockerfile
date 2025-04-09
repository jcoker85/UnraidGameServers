FROM debian:bullseye-slim

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update && \
    apt-get install -y wget jq lib32gcc-s1 && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /steamcmd

ENV GAME_NAME="Arma Reforger Docker Server"
ENV GAME_PASSWORD=""
ENV RCON_PASSWORD=""
ENV GAME_PASSWORD_ADMIN=""
ENV GAME_ADMINS=""
ENV GAME_SCENARIO_ID="{ECC61978EDCC2B5A}Missions/23_Campaign.conf"
ENV GAME_MAX_PLAYERS=32
ENV MAX_FPS=120

ENV DATA_DIR="/serverdata"
ENV STEAMCMD_DIR="${DATA_DIR}/steamcmd"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV WORKSHOP_DIR="${SERVER_DIR}/workshop"
ENV PROFILE_DIR="${SERVER_DIR}/profile"
ENV GAME_ID=1874900
ENV GAME_PARAMS=""
ENV GAME_PORT=2001
ENV RCON_PORT=19999
ENV A2S_PORT=17777
ENV VALIDATE=""
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV USERNAME=""
ENV PASSWRD=""
ENV USER="steam"
ENV DATA_PERM=770

RUN mkdir $DATA_DIR && \
	mkdir $STEAMCMD_DIR && \
	mkdir $SERVER_DIR && \
    mkdir $WORKSHOP_DIR && \
    mkdir $PROFILE_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/
COPY default-config.json /tmp

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]