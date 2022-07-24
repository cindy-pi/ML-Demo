
export VAR_SSIDNAME=$1
export VAR_SSIDPASS=$2
export VAR_SSH_PATH=$3
export VAR_HOSTNAME=$4

sed 's/VAR_HOSTNAME/'"$VAR_HOSTNAME"'/' ./firstboot.sh > /Volumes/boot/firstboot.sh
sed 's/VAR_SSIDNAME/'"$VAR_SSIDNAME"'/' ./wpa_supplicant.conf | sed 's/VAR_SSIDPASS/'"$VAR_SSIDPASS"'/' > /Volumes/boot/wpa_supplicant.conf
cp $VAR_SSH_PATH /Volumes/boot/authorized_keys
cp ssh				/Volumes/boot
cp unattended			/Volumes/boot

sed -i 'bak' 's/init=\/usr\/lib\/raspi-config\/init_resize.sh/cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1 init=\/bin\/bash -c "mount -t proc proc \/proc; mount -t sysfs sys \/sys; mount \/boot; source \/boot\/unattended" /' /Volumes/boot/cmdline.txt

chmod 777 /Volumes/boot/firstboot.sh


