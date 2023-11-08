FROM ich777/winehq-baseimage

ENV MAP="ge_archives"
ENV MAXPLAYERS="10"
ENV PORT_INCREMENT="0"

RUN dpkg --add-architecture i386 && \
    apt update && \
    apt install -y tar lib32gcc-s1 p7zip-full winbind xvfb && \
    mkdir -p /servers/geserver && \
    mkdir /servers/steamcmd && \
    useradd -d /servers -s /bin/bash steam

COPY ./GoldenEye_Source_v5.0.6_full_server_windows.7z /servers
COPY ./scripts/startup.sh /servers
COPY ./scripts/server.sh /servers

ENTRYPOINT ["/servers/startup.sh"]