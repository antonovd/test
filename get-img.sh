#!/bin/sh
#this is script for getting camera image from rtsp port
#today=`/bin/date '+%d-%m-%Y__%H-%M-%S'`;       #Used to generate filename
IP="192.168.xxx.xxx"                              # IP address Camera

#Ping IP-address of camera to see if it's online, otherwise we don't have to grab a snapshot
if ping -c 1 $IP > /dev/null ; then

#Grab snapshot from RTSP-stream

ffmpeg -y -rtsp_transport tcp -i 'rtsp://user:pass@192.168.xxx.xxx' -f image2 -vframes 1 -pix_fmt yuvj420p /DIR/img.jpeg

#Send pushnotification with URL to snapshot
#sh /volume1/@appstore/domoticz/var/scripts/bash/doorbell/pushover.sh -u PUSHOVER_USERKEY -a PUSHOVER_APPKEY -q "Doorbell" -m "https://dl.dropboxusercontent.com/u/YOUR_DROPBOX_PUBLICFOLDER_ID/doorbell_snapshots/$today.jpeg"

#Delete previous taken snapshots older than 7 days
find /DIR/ -name '*.jpeg' -mtime +7 -delete
fi