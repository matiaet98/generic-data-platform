#!/bin/bash

printf "\nHostname: "
read hostname
printf "\nDomainname: "
read domainname
printf "\nDocker IP address: "
read ip
printf "\nDocker network name: "
read network

echo "Input: "
echo "Hostname: ${hostname}"
echo "Domainname: ${domainname}"
echo "Docker IP address: ${ip}"
echo "Docker network name: ${network}"
printf "Are you sure? (y/n): "
read yon
echo ""

if [ $yon == "n" ]; then
    exit 1
fi

find config/ -type f -exec sed -i "s/<ip>/${ip}/g; s/<domainname>/${domainname}/g; s/<hostname>/${hostname}/g; s/<network>/${network}/g;" {} \;
sed -i "s/<ip>/${ip}/g; s/<domainname>/${domainname}/g; s/<hostname>/${hostname}/g; s/<network>/${network}/g;" docker-compose.yml

echo "All set; You can build the image now with docker build --rm -t <image name>:<tag> ."
