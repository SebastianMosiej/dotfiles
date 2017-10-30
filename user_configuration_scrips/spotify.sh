#!/bin/bash

echo "Installing Spotify"
add-apt-repository -r "deb http://repository.spotify.com testing non-free"
add-apt-repository "deb http://repository.spotify.com testing non-free"
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
apt-get update -qq
apt-get install spotify-client -qq
