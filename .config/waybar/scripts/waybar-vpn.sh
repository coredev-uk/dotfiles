#!/bin/sh

SERVER=$(protonvpn-cli status | grep Server: | tr -d ' ' | cut -d ':' -f2 | xargs)
IPADDR=$(protonvpn-cli status | grep IP: | tr -d ' ' | cut -d ':' -f2 | xargs)

if [ "$SERVER" ]; then
    echo "Connected ($SERVER - $IPADDR)"
else
    echo "Disconnected"
fi
