# docker-compose-samples
The goal of this repo is to offer a ready-to-use stack of containers. Clone the repo, update the config and run the containers you want.

NB: this stack uses compose V2, it is therefore important that you use an up-to-date version of docker compose. Check my public_script repo for an automated installation of docker and docker compose.

## How to use the repo
1. Clone the repository
2. Update the ".env" file with your variables, in particular the folder location and the passwords.
3. Create the "dockernet" and "arr_stack" networks
```
docker network create dockernet && docker network create arr_stack
```
4. Execute the `docker compose up -d` command for the containers you want to start, for example:
```
docker compose -f /portainer/docker-compose.yml up -d
```
If you want to start, stop or restart all the containers in one go, you can use the provided script with the following command:
```
sudo sh start-stop-restart_all_containers.sh
```
5. Update the access rights of the appdata folder.
When you first run the docker as sudo, the appdata subfolders are created by the root user and this can cause issues with certain containers. Run the following command and restart all the containers to fix this:
```
sudo chown -R ${USER}:${USER} /path/to/appdata
``` 
6. Configure your reverse proxy 
(see note below)


## Some notes
### The .env file
The ".env" file is shared between all the containers. 
It has lots of benefits like centralizing all the port mapping and sharing the path to various medias wihtin one parameter.
In this particular case it allows me to easily share the docker compose files without having to go through each of them to scramble the usernames, folders and passwords. :)

You can find good documentation on the docker website: https://docs.docker.com/compose/environment-variables/env-file/

### Reverse Proxy
The default reverse proxy is Caddy. It is very simple but yet very powerfull. It uses a file based configuration (see the "Caddyfile" provided). Just restart the container when you update the config.
If you prefer Nginx Proxy Manager, then stop the caddy container, delete the caddy folder (or rename the compose file) and rename the compose file in the npm folder to "docker-compose.yml". You can now start the npm container.

### Adding a new container to the stack
If you add a container to the stack that is not in the current repo, there are a few easy steps to properly integrate it.
1. use variables in the new compose file by replacing the port number or path name with the following syntax `${MyVariable}` (check what has been done in the existing containers)
2. add the new variables to the ".env" file `MyVariable=value`
3. create a symlink from the root ".env" file to the new containers subfolder (ex. for portainer) using the adhoc script.

NB: if you get an error like "WARNING: The `MyVariable` variable is not set. Defaulting to a blank string." when starting the container, it means that you did not properly add the variable to the ".env" file or that the symlink to the .env file wasn't created.
