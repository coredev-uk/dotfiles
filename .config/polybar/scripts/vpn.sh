#!/bin/sh

SERVER=$(protonvpn-cli status | grep Server: | tr -d ' ' | cut -d ':' -f2 | xargs)
IPADDR=$(protonvpn-cli status | grep IP: | tr -d ' ' | cut -d ':' -f2 | xargs)

if [ "$SERVER" ]; then
    echo "%{F#57F287}Connected%{F-} ($SERVER - $IPADDR)"
else
    echo "%{F#666}Disconnected%{F-}"
fi
