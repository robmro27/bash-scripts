#!/bin/bash
disk_usage=$(df -Ph /);
server_ip=$(dig +short myip.opendns.com @resolver1.opendns.com);

read -r -d '' EMAIL << EOM
File Usage IP: $server_ip
$disk_usage
EOM

mail  -aFrom:$1 -s "Disk Space $server_ip" $2 <<< "$EMAIL"
