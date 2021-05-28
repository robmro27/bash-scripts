#!/bin/bash
# /home/ubuntu/disk-usage-email/disk-usage.sh no-reply@pdc3.com devteam@spidr.design PDC3 

disk_usage=$(df -Ph /);
server_ip=$(dig +short myip.opendns.com @resolver1.opendns.com);

read -r -d '' EMAIL << EOM
File Usage IP: $server_ip
$disk_usage
EOM

mail  -aFrom:$1 -s "Disk Space - $3" $2 <<< "$EMAIL"
