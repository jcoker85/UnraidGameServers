# SteamCMD Docker Dedicated Game Server for Unraid
This will download and install SteamCMD and the associated dedicated game server.

**NOTE:** Please allow about 5 minutes for initial container startup with a good Internet connection. The game files and necessary runtimes only need to be downloaded once. 
To update to a newer version of the game, just restart the container. If you want to install a beta version of the game, change the GAME_ID parameter value to: 
```GAME_ID -beta BRANCH_NAME``` (e.g. ```294420 -beta latest_experimental``` would download the 7 Days to Die dedicated server from the latest_experimental branch).

## Windrose Dedicated Server

**NOTE:** After first startup of the server, shut it down and edit the following files to your liking: 
- YOUR_INSTALL_PATH/R5/ServerDescription.json
- YOUR_INSTALL_PATH/R5/Saved/SaveProfiles/Default/RocksDB/_gameVersion_/Worlds/_worldId_/WorldDescription.json

You can customize your server by modifying those two files. See here for more details: https://playwindrose.com/dedicated-server-guide/

Please note that there is no port forwarding required for this game, but it does rely on UPnP.

The invite code used to join the server will be in ServerDescription.json

### Run example
```
docker run --name WR -d \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/windrose:/serverdata/serverfiles \
	jcoker85/windrose
```

Heavily based off of https://github.com/ich777/docker-steamcmd-server. Thank you for your contributions!