# SteamCMD Docker Dedicated Game Server for Unraid
This will download and install SteamCMD and the associated dedicated game server.

**NOTE:** Please allow about 5 minutes for initial container startup with a good Internet connection. The game files and necessary runtimes only need to be downloaded once. 
To update to a newer version of the game, just restart the container. If you want to install a beta version of the game, change the GAME_ID parameter value to: 
```GAME_ID -beta BRANCH_NAME``` (e.g. ```294420 -beta latest_experimental``` would download the 7 Days to Die dedicated server from the latest_experimental branch).

## Sunkenland Dedicated Server

### Example Env params 
| Name               | Value                                                       | Example                                         |
|--------------------|-------------------------------------------------------------|-------------------------------------------------|
| STEAMCMD_DIR       | Folder for SteamCMD                                         | /serverdata/steamcmd                            |
| SERVER_DIR         | Folder for gamefile                                         | /serverdata/serverfiles                         |
| GAME_ID            | The application ID that the container downloads at startup. | 2667530                                         |
| GAME_PARAMS        | Game parameters for the server                              | -worldGuid 9966a2bb-37f0-40d2-ac43-789cdb58eaf7 |
| UID                | User Identifier                                             | 99                                              |
| GID                | Group Identifier                                            | 100                                             |
| VALIDATE           | Validates the game data                                     | false                                           |
| USERNAME           | Leave blank for anonymous login                             | blank                                           |
| PASSWRD            | Leave blank for anonymous login                             | blank                                           |

### Run example
```
docker run --name Sunkenland -d \
	-p 52160:52160/udp -p 52161:52161/udp -p 27015:27015/udp \
	--env 'GAME_ID=2667530' \
	--env 'GAME_PARAMS=-worldGuid 9966a2bb-37f0-40d2-ac43-789cdb58eaf7' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/icarus:/serverdata/serverfiles \
	jcoker85/sunkenland
```

Heavily based off of https://github.com/ich777/docker-steamcmd-server. Thank you for your contributions!