#!/usr/bin/bash

apt-get update
# apt-get install -y firefox

apt-get install -y pdfsam 
apt-get install -y xsane # scanner tools

apt-get install -y python-distutils-extra

# apt-get install -y open-ssh-server
# service restart ssh
# systemctl restart ssh
# apache? nginx?
apt-get install -y git 

apt-get install -y enigmail

apt-get install -y cryptsetup # create encrypted USB drive

# play media
apt-get install -y audacity
apt-get install -y browser-plugin-lightspark browser-plugin-gnash

apt-get install -y wajig # search packages more easily

apt-get install -y libreoffice # spreadsheet
apt-get install -y kmymoney
apt-get install -y fbreader comix
apt-get install -y virtualbox-qt virtualbox-dkms
apt-get install -y eyed3 easytag flac
apt-get install -y grsync gparted
apt-get install -y recoll
apt-get install -y gimp inkscape

# Backup software
apt-get install -y tcplay python-gpgme enigmail
apt-get install -y ibus-pinyin
apt-get install -y fonts-arphic-gbsn00lp fonts-arphic-gkai00mp ttf-hanazono
apt-get install -y anki

apt-get install -y r-base-dev # R :-)
apt-get install -y texlive-latex-recommended texlive-fonts-recommended texinfo texlive-latex-extra texlive-fonts-extra latex-xcolor
apt-get install -y rst2pdf python3-docutils

# Vim :-)
# place vim plugins in src/vim/bundle
apt-get install -y vim-gtk
apt-get install -y libx11-dev tmux htop ncurses-term latexmk

# Latex symbol selector
apt-get install -y libgtk2.0-dev libxml2-dev

# Python
apt-get install -y python-pip python-dev python-setuptools build-essential
pip install thefuck
pip install csvkit

# Rio
# wget https://raw.githubusercontent.com/jeroenjanssens/data-science-at-the-command-line/master/tools/Rio

# JSON
apt-get install -y jq
apt-get install -y imagemagick # display

echo "Manually install Truecrypt, Dropbox, SpiderOak"
# truecrypt
# dpkg -i src/spideroak*.deb # SpiderOak
# Dropbox
# dpkg -i src/dropbox*.deb
echo "Set-up Firefox Sync"
echo "Install gourmet"
echo "Set-up Rio"
# setup .Rprofile
# rpackages
echo "Manually install Latex symbol selector"
# manually install latex symbol selector
echo "manually install vimcom or vimcom.plus package in R"
echo "Run ibus-setup and set up dvorak keyboard"
