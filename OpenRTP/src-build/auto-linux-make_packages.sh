#!/bin/bash

export ECLIPSE_HOME=/home/openrtm/eclipse
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=/usr/lib/jvm/java-8-openjdk-amd64/bin:${PATH}
export ECLIPSE_VERSION
export OS=LINUX
export WORK_DIR=./work/linux

sh make_packages

cd packages
name=`find . -name "*ja-linux-gtk-x86_64.tar.gz" | xargs basename`
cp -r $name openrtp-linux-gtk-x86_64.tar.gz
name=`find . -name "*ja-linux-gtk.tar.gz" | xargs basename`
cp -r $name openrtp-linux-gtk.tar.gz
cd ..
