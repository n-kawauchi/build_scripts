#!/bin/bash

export ECLIPSE_HOME=/home/openrtm/eclipse_envs/eclipse-4.7.3
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=/usr/lib/jvm/java-8-openjdk-amd64/bin:${PATH}

rm -rf openrtp-*
rm -rf packages/*.tar.gz packages/*.zip
sh build_all clean
sh build_all
