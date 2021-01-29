#!/bin/bash

sudo apt update

# For convenience
cd ~
mkdir -p Downloads
mkdir -p Applications


# Bazelisk
# https://wiki.onosproject.org/display/ONOS/Installing+required+tools
# https://github.com/ederollora/Building_ONOS
cd ~/Downloads
wget https://github.com/bazelbuild/bazelisk/releases/download/v1.4.0/bazelisk-linux-amd64
chmod +x bazelisk-linux-amd64
sudo mv bazelisk-linux-amd64 /usr/local/bin/bazel
cd ~/onos
bazel version

# For VirtualboxGuest Additions
sudo apt install gcc make perl -y

# Some other utilities
sudo xterm terminator -y


# Some dependencies for ONOS
# https://wiki.onosproject.org/display/ONOS/Developer+Quick+Start
sudo apt install zip curl unzip bzip2 -y


# Python stuff
# https://wiki.onosproject.org/display/ONOS/Installing+required+tools
sudo apt install python python-pip python-dev python-setuptools -y
sudo apt install python3 python3-pip python3-dev python3-setuptools -y
pip3 install --upgrade pip
pip3 install selenium


# Git 
# https://wiki.onosproject.org/display/ONOS/Installing+required+tools
sudo apt-get install git git-review -y


# JDK 11 - Amazon Corretto
# Pointed out here: https://wiki.onosproject.org/display/ONOS/Developer+Quick+Start
# Steps: https://docs.aws.amazon.com/corretto/latest/corretto-11-ug/generic-linux-install.html
wget -O- https://apt.corretto.aws/corretto.key | sudo apt-key add -
sudo add-apt-repository 'deb https://apt.corretto.aws stable main' -y
sudo apt-get update
sudo apt-get install java-11-amazon-corretto-jdk java-common -y
java -version


# ONOS
# https://wiki.onosproject.org/display/ONOS/Getting+the+ONOS+core+source+code+using+git+and+Gerrit
cd ~
git clone https://gerrit.onosproject.org/onos
cd onos
git checkout onos-2.4


# Utility scripts
# Making more convenient ("Customize your Bash environment") : https://wiki.onosproject.org/display/ONOS/Developer+Quick+Start
echo -e "\n\n# ONOS" >> ~/.bashrc
echo "export ONOS_ROOT=~/onos" >> ~/.bashrc
echo "source \$ONOS_ROOT/tools/dev/bash_profile" >> ~/.bashrc


# Adding Apache Karaf and Maven to create own OAR apps
# https://wiki.onosproject.org/display/ONOS15/Installing+and+Running+ONOS
cd ~/Downloads
wget http://archive.apache.org/dist/karaf/3.0.5/apache-karaf-3.0.5.tar.gz
wget http://archive.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
tar -zxvf apache-karaf-3.0.5.tar.gz -C ../Applications/
tar -zxvf apache-maven-3.3.9-bin.tar.gz -C ../Applications/


# Build ONOS
# https://wiki.onosproject.org/display/ONOS/Building+ONOS+and+executing+unit+tests
cd ~/onos
bazel build onos


# Run ONOS (in one terminal, leave running)
# bazel run onos-local -- clean debug

# Connect to ONOS (in another terminal)
# cd ~/onos
# tools/test/bin/onos localhost