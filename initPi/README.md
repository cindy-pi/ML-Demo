
# This section is used to initialize your raspberry pi, and give support for shh access, wifi access, and hostname assignment

## How it works

```
  ## If you have not ssh keys run the following:
  ##   ssh-keygen -f ../keys/id_rsa -t rsa -N ""
  ## Then create you authorized keys file using folloiwng command:
  ##   cat ../keys/*.pub > ../keys/authorized_keys
  ##   chmod 644 ../keys/authorized_keys
  ##
  ## Burn your SD card using rapberry imager (Ref: https://www.raspberrypi.com/software/)A
  ##   You will want to burn the following OS:
  ##     - Raspberry Pi OS (Other)
  ##       - Raspberry PI OS LITE (64-bit)
  ## ReInsert you sd card
  ## Run command below with new host name (ex. pi01)
  ./push.sh {Your House SSID} {Your House SSID Password} {Path to Your SSH Public Key File} {Path to boot Mount Point} pi01 {ETH0 IP}

  ex. ./push.sh myhome secret ../keys/id_rsa /Volumes/boot pi01 10.10.10.11
  ex. ./push.sh myhome secret ../keys/id_rsa /Volumes/boot pi02 10.10.10.12
  ex. ./push.sh myhome secret ../keys/id_rsa /Volumes/boot pi03 10.10.10.13

  ## Eject your SD card
  ## Now you SD card is ready for pi cluster as pi01
  ## Repeat steps for pi02 ... piNN, where NN is number of pis in your cluster.

```


## You should now have SD cards, ready to deploy :)


