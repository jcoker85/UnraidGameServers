FROM ich777/winehq-baseimage

RUN apt-get update && \
	apt-get -y install lib32gcc-s1 xvfb screen && \
	wget -q -O /usr/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && \
	chmod +x /usr/bin/winetricks && chown 755 /usr/bin/winetricks && \
	rm -rf /var/lib/apt/lists/*

ENV DATA_DIR="/serverdata"
ENV STEAMCMD_DIR="${DATA_DIR}/steamcmd"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV GAME_ID=2667530
ENV GAME_PARAMS="-worldGuid 370c779b-d678-49d5-86b0-e793d94e55f8 -region us"
ENV GAME_PORT=27015
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
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/
COPY /SunkenlandDocker~370c779b-d678-49d5-86b0-e793d94e55f8/ /tmp/SunkenlandDocker~370c779b-d678-49d5-86b0-e793d94e55f8/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]