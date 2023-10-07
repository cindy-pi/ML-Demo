

export VAR_SSIDNAME=$1
export VAR_SSIDPASS=$2
export VAR_SSH_PATH=$3
export  VAR_BOOTVOL=$4
export VAR_HOSTNAME=$5
export VAR_HOSTIP=$6

sed 's/VAR_HOSTNAME/'"$VAR_HOSTNAME"'/' ./firstboot.sh | sed 's/VAR_HOSTIP/'"$VAR_HOSTIP"'/' > $VAR_BOOTVOL/firstboot.sh
sed 's/VAR_SSIDNAME/'"$VAR_SSIDNAME"'/' ./wpa_supplicant.conf | sed 's/VAR_SSIDPASS/'"$VAR_SSIDPASS"'/' > $VAR_BOOTVOL/wpa_supplicant.conf
cp $VAR_SSH_PATH $VAR_BOOTVOL/authorized_keys
cp ssh				$VAR_BOOTVOL
cp unattended			$VAR_BOOTVOL
cp userconf.txt			$VAR_BOOTVOL

sed -i 's/init=.*/cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1 init=\/bin\/bash -c "mount -t proc proc \/proc; mount -t sysfs sys \/sys; mount \/boot; source \/boot\/unattended" /' $VAR_BOOTVOL/cmdline.txt

chmod 777 $VAR_BOOTVOL/firstboot.sh


