# SteamCMD Docker Dedicated Game Server for Unraid
This will download and install SteamCMD and the associated dedicated game server.

**NOTE:** Please allow about 5 minutes for initial container startup with a good Internet connection. The game files and necessary runtimes only need to be downloaded once. 
To update to a newer version of the game, just restart the container. If you want to install a beta version of the game, change the GAME_ID parameter value to: 
```GAME_ID -beta BRANCH_NAME``` (e.g. ```294420 -beta latest_experimental``` would download the 7 Days to Die dedicated server from the latest_experimental branch).

## Swords 'n Magic and Stuff Dedicated Server

**NOTE:** The name of the server must be 2-5 of the allowed words found in Saved/Logs/AllowedWords.txt. You can use the default name to start the server and check this file.

### Example Environment Variables
| Name               | Value                                                       | Example                 |
|--------------------|-------------------------------------------------------------|-------------------------|
| SNM_NAME           | Name of the server                                          | Turtle Market Puzzle    |
| SNM_OWNER_STEAM_ID | Steam ID of the server owner                                | 1234567890              |
| SNM_PASSWORD       | Password of the server                                      | docker                  |

**NOTE:** Please check the Dockerfile for other environment variables that can be set and what their defaults are.

### Run example
```
docker run --name SNMAS -d \
	-p 7777:7777/udp -p 27015:27015/udp \
	--env 'SNM_NAME=Turtle Market Puzzle' \
	--env 'SNM_OWNER_STEAM_ID=1234567890' \
	--env 'SNM_PASSWORD=docker' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/swordsnmagicandstuff:/serverdata/serverfiles \
	jcoker85/swordsnmagicandstuff
```

Heavily based off of https://github.com/ich777/docker-steamcmd-server. Thank you for your contributions!