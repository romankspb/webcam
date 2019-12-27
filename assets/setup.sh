#!/usr/bin/env bash

set -e
trap "echo '******* ERROR: Something went wrong.'; exit 1" SIGTERM
trap "echo '******* Caught SIGINT signal. Stopping...'; exit 2" SIGINT

echo "Setting up..."

dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf install ffmpeg nodejs.x86_64 unzip wget -y
npm -g install http-server
mkdir -p /opt
cd /opt
wget https://github.com/phoboslab/jsmpeg/archive/master.zip
unzip master.zip
rm -f master.zip
cd jsmpeg-master
mv view-stream.html index.html
mv /assets/favicon.ico .
npm install ws

echo "Done."
