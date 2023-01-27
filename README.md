# docker-compose-samples
Collection of docker-compose samples

In general they are configures to store their data in a subfolder with the same name (ex: plex/plex/*) in case you want to use them in a stack.

Most use a predefined network "dockernet" which must be created (once) before running them with the following command:
```
docker network create -d bridge dockernet
```

If you want to use one env file for all the containers, you can create a symlink with the following command (ex. for portainer)
```
ln -s ../.env portainer/.env
```

