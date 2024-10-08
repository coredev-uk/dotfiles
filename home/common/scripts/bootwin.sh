#!/bin/sh
sudo su - <<EOF
efibootmgr -n 0000
reboot
EOF