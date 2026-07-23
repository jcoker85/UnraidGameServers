# SteamCMD Docker Dedicated Game Server for Unraid
This will download and install SteamCMD and the associated dedicated game server.

**NOTE:** Please allow about 5 minutes for initial container startup with a good Internet connection. The game files and necessary runtimes only need to be downloaded once. 
To update to a newer version of the game, just restart the container. If you want to install a beta version of the game, change the GAME_ID parameter value to: 
```GAME_ID -beta BRANCH_NAME``` (e.g. ```294420 -beta latest_experimental``` would download the 7 Days to Die dedicated server from the latest_experimental branch).

## Sunkenland Dedicated Server

**NOTE:** To adjust the world name, go into your server files directory, then go to "/WINE64/drive_c/users/steam/AppData/LocalLow/Vector3 Studio/Sunkenland/Worlds" and
change the name of the folder. To change the description, you can edit the WorldSetting.json file inside of this directory. You can also provide your own Worlds directory
by deleting the existing one and copying your own into the directory. Make sure to update the worldGuid in the Game Parameters section if you use your own world.

**NOTE:** For version v0.8+, previous worlds are incompatible. To generate a new default world, just delete the existing Worlds directory and restart the container. Make sure 
to update the worldGuid in the Game Parameters section. The worldGuid below is the one you should use if generating a new default world.

**NOTE:** You can use the Game Parameters section to add several options, see here for more details: https://www.sunkenlandgame.com/post/dedicated-server-user-manual

### Example Environment Variables
| Name               | Value                                              | Example                                                    |
|--------------------|----------------------------------------------------|------------------------------------------------------------|
| GAME_PARAMS        | Game parameters for the server (see documentation) | -worldGuid b5460da7-91c5-4e59-98e3-510aa6805207 -region us |

**NOTE:** Please check the Dockerfile for other environment variables that can be set and what their defaults are.

### Run example
```
docker run --name Sunkenland -d \
	-p 27015:27015/udp \
	--env 'GAME_PARAMS=-worldGuid b5460da7-91c5-4e59-98e3-510aa6805207' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/sunkenland:/serverdata/serverfiles \
	jcoker85/sunkenland
```

Heavily based off of https://github.com/ich777/docker-steamcmd-server. Thank you for your contributions!