# SteamCMD Docker Dedicated Game Server for Unraid
This will download and install SteamCMD and the associated dedicated game server.

**NOTE:** Please allow about 5 minutes for initial container startup with a good Internet connection. The game files and necessary runtimes only need to be downloaded once. 
To update to a newer version of the game, just restart the container. 

## Goldeneye Source Dedicated Server

**NOTE:** After initial server startup, you can customize the server configuration by accessing geserver/gesource/cfg/server.cfg. 

### Example Env params 
| Name         | Value                                          | Example     |
|--------------|------------------------------------------------|-------------|
| MAP          | Starting map                                   | ge_caves    |
| MAX_PLAYERS  | Maximum number of players                      | 10          |
| GAME_PARAMS  | Game parameters                                | -port 27030 |
| INSTALL_MODS | Install Metamod:Source 1.12 and Sourcemod 1.12 | true        |

### Run example
```
docker run --name GESource -d \
	-p 27030:27030/tcp -p 27030:27030/udp \
	--env 'MAP=ge_caves' \
	--env 'MAX_PLAYERS=10' \
	--env 'GAME_PARAMS=-port 27030' \
	--env 'INSTALL_MODS=true' \
	--volume /path/to/geserver:/servers/geserver \
	jcoker85/goldeneyesourceserver
```

Heavily based off of https://github.com/ich777/docker-steamcmd-server. Thank you for your contributions!