#!/bin/bash

if [[ ! -d /home/$1/TeamViz ]]; then
  apt-get install libenchant1c2a
  runuser -l $1 -c'wget -nv http://www.teamviz.com/d/TeamViz.3.2.x64.tar.gz;tar zxf TeamViz.3.2.x64.tar.gz; rm TeamViz.3.2.x64.tar.gz; ln -s ~/TeamViz/TeamViz ~/bin/TeamViz'
  wget -nv http://ftp.pl.debian.org/debian/pool/main/libg/libgcrypt11/libgcrypt11_1.5.0-5+deb7u3_amd64.deb
  wget -nv http://security.debian.org/debian-security/pool/updates/main/g/gnutls26/libgnutls26_2.12.20-8+deb7u4_amd64.deb
  wget -nv http://ftp.pl.debian.org/debian/pool/main/libt/libtasn1-3/libtasn1-3_2.13-2+deb7u2_amd64.deb
  dpkg -i libgcrypt11_1.5.0-5+deb7u3_amd64.deb
  dpkg -i libgnutls26_2.12.20-8+deb7u4_amd64.deb
  dpkg -i libtasn1-3_2.13-2+deb7u2_amd64.deb
  rm *.deb
fi
