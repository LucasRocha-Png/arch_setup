#!/bin/bash

SYSTEMD_PATH=/etc/systemd/network/20-wired.network
DEVICE=$1

echo "Configuring your network"...

if [ "$#" -eq 0 ]; then
echo "Please, check 'ping addr' to see your device and pass as an argument."
exit 1
fi

if [ ! -d "/sys/class/net/$DEVICE" ]; then
echo "Device '$DEVICE' not found at 'ip addr'..."
exit 1
fi

echo "Configurating for the device $DEVICE"

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
sleep 2

