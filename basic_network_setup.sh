#!/bin/bash

SYSTEMD_PATH=/etc/systemd/network/20-wired.network

echo "Configuring your network"...
echo -e "Availables devices:\n"
ls /sys/class/net/
read -p "Type device name: " DEVICE


if [[ ! -d "/sys/class/net/$DEVICE" || -z $DEVICE ]]; then
echo "$DEVICE not found. Check 'ip addr' to see all available devices."
exit 1
fi

echo "Configurating the device $DEVICE"

systemctl enable --now systemd-networkd
systemctl start systemd-networkd
systemctl enable --now systemd-resolved
systemctl start systemd-resolved

echo "Creating configuring file at $SYSTEMD_PATH"
touch $SYSTEMD_PATH
echo -e "[Match]\nName=$DEVICE\n\n[Network]\nDHCP=yes" >  $SYSTEMD_PATH

systemctl restart systemd-networkd
systemctl restart systemd-resolved
ip link set $DEVICE up

