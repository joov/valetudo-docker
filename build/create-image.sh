#!/bin/bash

ssh-keygen -t ed25519 -C "${EMAIL_ADDR}" -N 123456 -f ~/.ssh/id_ed25519

git clone https://github.com/dgiese/dustcloud.git 
mkdir valetudo
pushd valetudo
wget https://github.com/Hypfer/Valetudo/releases/download/0.4.0/valetudo
mkdir deployment
pushd deployment
wget https://github.com/Hypfer/Valetudo/raw/master/deployment/valetudo.conf
mkdir etc
pushd etc
wget https://github.com/Hypfer/Valetudo/raw/master/deployment/etc/hosts
wget https://github.com/Hypfer/Valetudo/raw/master/deployment/etc/rc.local
popd
popd
popd
mkdir firmware
pushd firmware
wget https://dustbuilder.xvm.mit.edu/pkg/${ROBOT_TYPE}/${FIRMWARE_VERSION}
../dustcloud/devices/xiaomi.vacuum/firmwarebuilder/imagebuilder.sh \
     --firmware=${FIRMWARE_VERSION} \
     --public-key=$HOME/.ssh/id_ed25519.pub \
     --valetudo-path=../valetudo \
     --disable-firmware-updates \
     --ntpserver=${NTP_SERVER} \
     --replace-adbd