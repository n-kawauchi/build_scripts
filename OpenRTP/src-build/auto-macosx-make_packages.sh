#!/bin/bash

export ECLIPSE_HOME=/home/openrtm/eclipse
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=/usr/lib/jvm/java-8-openjdk-amd64/bin:${PATH}
export ECLIPSE_VERSION
export OS=MACOS
export WORK_DIR=./work/macosx
export BIT=64

sh make_packages
