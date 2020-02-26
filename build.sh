#!/bin/bash

docker rmi matiaet98/mdp:latest
docker build --rm -t matiaet98/mdp:latest .

