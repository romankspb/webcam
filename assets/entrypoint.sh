#!/usr/bin/env bash

case "$1" in
    -h|--help)
	echo -e "Usage:\n\tdocker run --name=webcam -d --privileged -p 8080:8080 -p 8082:8082 -v /dev/video0:/dev/video0 romankspb/webcam"
	exit 0
    ;;
esac

set -e

trapper() {
    trap "echo 'Caught SIGTERM signal, shutting down...'; stop" SIGTERM;
    trap "echo 'Caught SIGINT signal, shutting down...'; stop" SIGINT;
}

start() {
	echo "Starting..."
	cd /opt/jsmpeg-master
	node websocket-relay.js webcam 8081 8082 &
	http-server &
	ffmpeg -f v4l2 -framerate 25 -video_size 640x480 -i /dev/video0 -f mpegts -codec:v mpeg1video -s 640x480 -b:v 1000k -bf 0 -loglevel panic http://localhost:8081/webcam
	trapper
}

stop() {
    echo "Stopping..."
    trap '' SIGINT SIGTERM
    exit 0
}

trap 'stop' SIGINT SIGTERM

start
