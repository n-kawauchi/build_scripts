#!/bin/bash

export ECLIPSE_HOME=/home/openrtm/eclipse
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=/usr/lib/jvm/java-8-openjdk-amd64/bin:${PATH}
export ECLIPSE_VERSION
export OS=WIN32
export WORK_DIR=./work/win32

sh make_packages

cd packages
name=`find . -name *ja-win32.zip | xargs basename`
cp -r $name openrtp.zip
cd ..
