# Webcam
Stream video from your usb camera in one minute (ffmpeg, jsmpeg and nodejs)

# Create docker image
git clone https://github.com/romankspb/webcam.git && cd webcam && docker build .

# Usage
Run docker container:

docker run --name=webcam -d --privileged -p 8080:8080 -p 8082:8082 -v /dev/video0:/dev/video0 romankspb/webcam

Open url:

http://localhost:8080
