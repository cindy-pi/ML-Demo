#!/bin/bash


NEW_NAME="VAR_HOSTNAME"
echo $NEW_NAME > /etc/hostname
sed -i "s/raspberrypi/$NEW_NAME/g" /etc/hosts
hostname $NEW_NAME

mkdir -p /home/pi/.ssh
cp /boot/authorized_keys /home/pi/.ssh/authorized_keys
chmod 600 /home/pi/.ssh/authorized_keys
chown pi /home/pi/.ssh/authorized_keys

/usr/lib/raspi-config/init_resize.sh
