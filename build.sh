#!/bin/bash

echo "Hostname: "
read hostname
echo "Domainname: "
read domainname
echo "Docker IP address: "
read ip
echo "Docker network name: "
read network

echo "Input: "
echo "Hostname: ${hostname}"
echo "Domainname: ${domainname}"
echo "Docker IP address: ${ip}"
echo "Docker network name: ${network}"
echo "Are you sure? (y/n)"
read yon

if [ $yon == "n" ]; then
    exit 1
fi

# sed -i "s/<ip>/${ip}/g; s/<domainname>/${domainname}/g; s/<hostname>/${hostname}/g; s/<network>/${network}/g;" a.txt



docker rmi matiaet98/mdp:latest
docker build --rm -t matiaet98/mdp:latest .

