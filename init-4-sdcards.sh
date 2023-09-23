

echo Starting Formating of 4 SD Cards

export RASPOS_URL=https://downloads.raspberrypi.org/raspios_lite_arm64/images/raspios_lite_arm64-2023-05-03/2023-05-03-raspios-bullseye-arm64-lite.img.xz
export RASPOS_IMG=2023-05-03-raspios-bullseye-arm64-lite

export WIFI_SSID=******
export WIFI_PASS=******
export SSH_KEY=../keys/authorized_keys
export PIUSER_PASS=tester

lsblk
mkdir git
cd git
git clone https://github.com/cindy-pi/ML-Demo.git
cd ML-Demo/initPi
echo $PIUSER_PASS | openssl passwd -6 -stdin | xargs -I % echo "pi:"% > userconf.txt
ssh-keygen -f ../keys/id_rsa -t rsa -N ""
cat ../keys/*.pub > ../keys/authorized_keys
chmod 644 ../keys/authorized_keys
wget $RASPOS_URL
xz -d $RASPOS_IMG.img.xz
mv $RASPOS_IMG.img pi-os.img

echo Unmounting the SD Cards for reformating
lsblk | grep "─sd" | awk '{print $7}' | xargs umount

echo Deleting the Partitions
sfdisk --delete /dev/sda
sfdisk --delete /dev/sdb
sfdisk --delete /dev/sdc
sfdisk --delete /dev/sdd

echo Starting 4 parallel jobs for writing image to SD cards
nohup dd bs=4M if=pi-os.img of=/dev/sda status=progress conv=fsync > sda.log &
nohup dd bs=4M if=pi-os.img of=/dev/sdb status=progress conv=fsync > sdb.log &
nohup dd bs=4M if=pi-os.img of=/dev/sdc status=progress conv=fsync > sdc.log &
nohup dd bs=4M if=pi-os.img of=/dev/sdd status=progress conv=fsync > sdd.log &

echo "Waiting for all jobs to finish..."
wait
echo "All jobs are done!"

echo Creating Mount Directories in preperation for initializing cards for Ansible deployment
mkdir -p /mnt/sda
mkdir -p /mnt/sdb
mkdir -p /mnt/sdc
mkdir -p /mnt/sdd

echo Mounting the SD Cards to write new configs on Pi Boot, for the SD Cards
mount /dev/sda1 /mnt/sda
mount /dev/sdb1 /mnt/sdb
mount /dev/sdc1 /mnt/sdc
mount /dev/sdd1 /mnt/sdd

echo Pushing new configs to 4 SD cards, this will allow for Anisible install on the cluster
./push.sh $WIFI_SSID $WIFI_PASS $SSH_KEY /mnt/sda pi11 10.10.10.11
./push.sh $WIFI_SSID $WIFI_PASS $SSH_KEY /mnt/sdb pi12 10.10.10.12
./push.sh $WIFI_SSID $WIFI_PASS $SSH_KEY /mnt/sdc pi13 10.10.10.13
./push.sh $WIFI_SSID $WIFI_PASS $SSH_KEY /mnt/sdd pi14 10.10.10.14

echo Unmounting the SD cards do they can safely be pulled from host formater, and then inserting into fresh cluster

umount /mnt/sda
umount /mnt/sdb
umount /mnt/sdc
umount /mnt/sdd
