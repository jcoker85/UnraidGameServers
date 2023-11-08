# SteamCMD Docker Dedicated Game Server for Unraid
This will download and install SteamCMD and the associated dedicated game server.

**NOTE:** Please allow about 5 minutes for initial container startup with a good Internet connection. The game files and necessary runtimes only need to be downloaded once. 
To update to a newer version of the game, just restart the container. If you want to install a beta version of the game, change the GAME_ID parameter value to: 
```GAME_ID -beta BRANCH_NAME``` (e.g. ```294420 -beta latest_experimental``` would download the 7 Days to Die dedicated server from the latest_experimental branch).

## Swords 'n Magic and Stuff Dedicated Server

**NOTE:** The name of the server must be 2-5 of the allowed words found in Saved/Logs/AllowedWords.txt. You can use the default name to start the server and check this file


### Example Env params 
| Name               | Value                                                       | Example                 |
|--------------------|-------------------------------------------------------------|-------------------------|
| STEAMCMD_DIR       | Folder for SteamCMD                                         | /serverdata/steamcmd    |
| SERVER_DIR         | Folder for gamefile                                         | /serverdata/serverfiles |
| GAME_ID            | The application ID that the container downloads at startup. | 2058450                 |
| SNM_NAME           | Name of the server                                          | Turtle Market Puzzle    |
| SNM_OWNER_STEAM_ID | Steam ID of the server owner                                | 1234567890              |
| SNM_PASSWORD       | Password of the server                                      | docker                  |
| UID                | User Identifier                                             | 99                      |
| GID                | Group Identifier                                            | 100                     |
| VALIDATE           | Validates the game data                                     | false                   |
| USERNAME           | Leave blank for anonymous login                             | blank                   |
| PASSWRD            | Leave blank for anonymous login                             | blank                   |

### Run example
```
docker run --name SNMAS -d \
	-p 7777:7777/udp -p 27015:27015/udp \
	--env 'GAME_ID=2058450' \
	--env 'SNM_NAME=Turtle Market Puzzle' \
	--env 'SNM_OWNER_STEAM_ID=1234567890' \
	--env 'SNM_PASSWORD=docker' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/icarus:/serverdata/serverfiles \
	jcoker85/swordsnmagicandstuff
```

Heavily based off of https://github.com/ich777/docker-steamcmd-server. Thank you for your contributions!