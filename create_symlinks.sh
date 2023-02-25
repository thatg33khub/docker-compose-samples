#!/bin/bash

# Use path if you run this script outside of your docker folder
# cd ~/git/docker-compose-samples


for dir in */; do
ln -s ../.env $dir/.env
done;
