#!/bin/bash


NEW_NAME="VAR_HOSTNAME"
echo $NEW_NAME > /etc/hostname
sed -i "s/raspberrypi/$NEW_NAME/g" /etc/hosts
hostname $NEW_NAME

mkdir -p /home/pi/.ssh
cp /boot/authorized_keys /home/pi/.ssh/authorized_keys
chmod 600 /home/pi/.ssh/authorized_keys
chown pi /home/pi/.ssh/authorized_keys


cat <<EOF > /etc/default/keyboard
XKBMODEL="pc105"
XKBLAYOUT="us"
XKBVARIANT=""
XKBOPTIONS=""
BACKSPACE="guess"
EOF

rm /etc/profile.d/raspi-config.sh

export CMDLINE=`cat /boot/cmdline.txt`
export CMDLINE=$CMDLINE" ip=VAR_HOSTIP::0.0.0.0:255.255.255.0:VAR_HOSTNAME:eth0:off"
echo $CMDLINE > /boot/cmdline.txt

echo "arm_64bit=1" >> /boot/config.txt


/usr/lib/raspi-config/init_resize.sh
