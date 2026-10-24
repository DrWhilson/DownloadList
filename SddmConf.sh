#!/bin/bash

mkdir -p /usr/share/sddm/themes 

cp -r ./sddm_conf/themes/* /usr/share/sddm/themes/

cp ./sddm_conf/sddm.conf /etc/sddm.conf

mkdir /etc/sddm.conf.d/
cp -r ./sddm_conf/sddm.conf.d/* /etc/sddm.conf.d/
