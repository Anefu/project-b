#!/bin/bash
apt-get update
apt-get -y install git binutils
git clone https://github.com/aws/efs-utils /tmp
sh /tmp/efs-utils/build-deb.sh
apt-get -y install /tmp/efs-utils/build/amazon-efs-utils*deb
mkdir /efs

mount -t efs ${file_system} /efs/