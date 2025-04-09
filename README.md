# SteamCMD Docker Dedicated Game Server for Unraid
This will download and install SteamCMD and the associated dedicated game server.

**NOTE:** Please allow about 5 minutes for initial container startup with a good Internet connection. The game files and necessary runtimes only need to be downloaded once. 
To update to a newer version of the game, just restart the container. If you want to install a beta version of the game, change the GAME_ID parameter value to: 
```GAME_ID -beta BRANCH_NAME``` (e.g. ```294420 -beta latest_experimental``` would download the 7 Days to Die dedicated server from the latest_experimental branch).

## Arma Reforger Dedicated Server

**NOTE:** Additional server configuration can be modified in default-config.json, located in the server installation directory, but the environment variables will override
if they are available to be set. Official documentation can be found at: https://community.bistudio.com/wiki/Arma_Reforger:Server_Hosting

### Example Environment Variables 
| Name             | Value                                               | Example                                         |
|------------------|-----------------------------------------------------|-------------------------------------------------|
| GAME_NAME        | Server display name                                 | Docker Server                                   |
| GAME_PASSWORD    | Password for accessing the server                   | dockerPassword                                  |
| GAME_MAX_PLAYERS | The max numbers of players that can join the server | 32                                              |
| GAME_SCENARIO_ID | The scenario the server will run                    | {ECC61978EDCC2B5A}Missions/23_Campaign.conf                                                |

**NOTE:** Please check the Dockerfile for other environment variables that can be set and what their defaults are. 

### Run example
```
docker run --name ArmaReforger -d \
	-p 2001:2001/udp \
	--env 'GAME_NAME=ArmaDockerServer' \
	--env 'GAME_MAX_PLAYERS=32' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/armareforger:/serverdata/serverfiles \
	jcoker85/armareforger
```

Heavily based off of https://github.com/ich777/docker-steamcmd-server. Thank you for your contributions!