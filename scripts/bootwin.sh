#!/bin/sh
sudo su - <<EOF
systemctl reboot --boot-loader-entry=bootmgfw.efi
EOF
