# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Swords 'n Magic and Stuff and run it.

**NOTE:** Make sure to fill out the name, owner, and password environment variables prior to starting the server!

**ATTENTION:** First startup can take very long since it downloads the gameserver files and it also installs the runtimes which can take quite some time! 

**First Start Notice:** On First startup the container installs the necessary runtimes and it might seem that the container hangs but please be patient since the installation can take very long on some systems (5 minutes+).

Update Notice: Simply restart the container if a newer version of the game is available.

## Example Env params 
| Name | Value                                                                                                                                                                                                                                                 | Example                 |
| --- |-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------|
| STEAMCMD_DIR | Folder for SteamCMD                                                                                                                                                                                                                                   | /serverdata/steamcmd    |
| SERVER_DIR | Folder for gamefile                                                                                                                                                                                                                                   | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '2089300 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 2058450                 |
| SNM_NAME | Name of the server                                                                                                                                                                                                                                    | Turtle Market Puzzle    |
| SNM_OWNER_STEAM_ID | Steam ID of the server owner                                                                                                                                                                                                                          | 1234567890              |
| SNM_PASSWORD | Password of the server | docker                  |
| UID | User Identifier                                                                                                                                                                                                                                       | 99                      |
| GID | Group Identifier                                                                                                                                                                                                                                      | 100                     |
| VALIDATE | Validates the game data                                                                                                                                                                                                                               | false                   |
| USERNAME | Leave blank for anonymous login                                                                                                                                                                                                                       | blank                   |
| PASSWRD | Leave blank for anonymous login                                                                                                                                                                                                                       | blank                   |

## Run example
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

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver & ich777, thank you for this wonderful Docker.