
# This section is used to initialize your raspberry pi, and give support for shh access, wifi access, and hostname assignment

## How it works

```
  ## Burn your SD card using rapberry imager
  ## ReInsert you sd card
  ## Run command below with new host name (ex. pi01)
  ./push.sh {Your House SSID} {Your House SSID Password} {Path to Your SSH Public Key File} {Path to boot Mount Point} pi01 {ETH0 IP}

  ex. ./push.sh myhome secret ../keys/id_rsa /Volumes/boot pi01 10.10.10.11

  ## Eject your SD card
  ## Now you SD card is ready for pi cluster as pi01
  ## Repeat steps for pi02 ... piNN, where NN is number of pis in your cluster.

```


## You should now have SD cards, ready to deploy :)


