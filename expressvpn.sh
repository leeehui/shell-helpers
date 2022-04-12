#!/bin/sh

locations=`expressvpn list | tail -n +6 | awk -F " " '{print $1}'`
duration="30s"

echo $locations

for loc in $locations
do
    echo "connecting $loc ..."
    timeout -k $duration $duration expressvpn connect $loc
    res=$?
    if [ $res = "0" ]; then
        echo "succeded, exit."
        break
    else
        expressvpn disconnect
        echo "failed, continue."
    fi
done
