#!/bin/sh

SRV=$(protonvpn-cli status | grep Server: | tr -d ' ' | cut -d ':' -f2 | xargs)
IP=$(protonvpn-cli status | grep IP: | tr -d ' ' | cut -d ':' -f2 | xargs)

if [ "$SRV" ]; then
	if [[ $1 == "--waybar" ]]; then
		echo '{"text": "Connected ('$SRV')", "class": "custom-vpn", "alt": "'$IP' ('$(protonvpn-cli status | grep Protocol: | tr -d ' ' | cut -d ':' -f2 | xargs)')"}'
	else
		echo "Connected ($SRV - $IP)"
	fi
else
	echo ""
fi
