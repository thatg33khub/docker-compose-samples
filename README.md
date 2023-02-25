# docker-compose-samples
Collection of docker-compose samples

NB: this stack uses compose V2, it is therefore important that you use an up to date version of docker compose

## Folder structure
The folder structure is supposed to look like this:
```
/home/user/docker/
    | .env
    |-- bitwarden/
    |     |-- docker-compose.yml
    |-- portainer/
    |     |-- docker-compose.yml
    |...

/path/to/appdata/
    |-- bitwarden/
    |    |-- ...
    |-- portainer/
    |     |-- ...
    |...

/path/to/medias/
    |-- ...
```

NB: Unlike most users, the appdata is not a subfolder of the container (ex.: docker/portainer/appdata) because I like to keep it separate. If you want to have everyting inside the "docker" folder, just set the "appdata" path location to "/home/user/docker/appdata" in the ".env" file.


## How to use the repo
The steps are very simple:

1. Clone the repository
2. Update the ".env" file with your variables, in particular the folder location and the different passwords.
3. Create the required folders with your user (not as root) to avoid access right issues.
4. Execute the `docker compose up -d` command for the containers you want to start, for example:
```
docker compose -f /portainer/docker-compose.yml up -d
```

If you want to start, stop or restart all the containers in one go, you can use the provided script with the following command:
```
sudo sh start-stop-restart_all_containers.sh
```

4. If you have issues with some containers not working properly, it might be due to an access right issue with the folders created as root when running the containers for the first time. In this case run the following command to change the owner of the appdata folder and restart the container:
```
sudo chown -R ${USER}:${USER} /path/to/appdata
```


## Some notes
### The .env file
The ".env" file is shared between all the containers. 
It has lots of benefits but in this particular case it allows you to easily share docker compose files without having to go through each of them to scramble the usernames, folders and passwords. You just need to scramble the ".env" file and you are all set.  ;)

You can find good documentation on the docker website: https://docs.docker.com/compose/environment-variables/env-file/


### Adding a new container to the stack
If you add a container to the stack that is not in the current repo, there are a few easy steps to properly integrate it.
1. use variables in the new compose file by replacing the port number or path name with the following syntax `${MyNewVariable}` (check what has been done in the existing containers)
2. add the new variables to the ".env" file `MyNewVariable=xxx`
3. create a symlink from the root ".env" file to the new containers subfolder (ex. for portainer)
```
ln -s ../.env portainer/.env
```


NB: if you get an error like "WARNING: The `MyNewVariable` variable is not set. Defaulting to a blank string." when starting the container, it means that you did not properly add the variable to the ".env" file.
