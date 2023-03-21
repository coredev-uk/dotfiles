#!/bin/sh

STATUS=$(nordvpn status | grep Status | tr -d ' ' | cut -d ':' -f2)
CITY=$(nordvpn status | grep City | tr -d ' ' | cut -d ':' -f2)
IPADDR=$(nordvpn status | grep IP | tr -d ' ' | cut -d ':' -f2)

if [ "$STATUS" = "Connected" ]; then
    echo "Connected ($CITY - $IPADDR)"
else
    echo ""
fi