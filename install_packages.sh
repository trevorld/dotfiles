#!/usr/bin/bash

echo "Manually install Truecrypt, Dropbox, SpiderOak"
# sudo apt-get install firefox
echo "Set-up Firefox Sync"

# apt-get install konqueror

apt-get install pdfsam xsane # scanner tools


# version control software
# sudo apt-get install git mercurial subversion
apt-get install git 

apt-get install enigmail

# play media
#apt-get install miro vlc
apt-get install audacity
apt-get install chromium-browser
apt-get install vlc browser-plugin-vlc
apt-get install browser-plugin-lightspark browser-plugin-gnash
# Steam
apt-get install wajig # search packages more easily

apt-get install calligra libreoffice # spreadsheet
apt-get install kmymoney
apt-get install fbreader comix
apt-get install virtualbox-qt virtualbox-dkms
apt-get install eyed3 easytag flac
apt-get install grsync gparted
apt-get install recoll
apt-get install gimp inkscape

# Backup software
apt-get install tcplay
# truecrypt
# dpkg -i src/spideroak*.deb # SpiderOak
# Dropbox
# apt-get install python-gpgme
# dpkg -i src/dropbox*.deb
apt-get install ibus-pinyin
apt-get install fonts-arphic-gbsn00lp fonts-arphic-gkai00mp ttf-hanazono
apt-get install anki
echo "Run ibus-setup and set up dvorak keyboard"

apt-get install r-base-dev # R :-)
# setup .Rprofile
# rpackages
# sudo apt-get install texlive-latex-base
apt-get install texlive-latex-recommended texlive-fonts-recommended texinfo texlive-latex-extra texlive-fonts-extra
apt-get install latex-xcolor
apt-get install rst2pdf qpdf python3-docutils

# Vim :-)
# place vim plugins in src/vim/bundle
apt-get install vim-gtk 
echo "manually install vimcom or vimcom.plus package in R"
apt-get install libx11-dev tmux ncurses-term latexmk

# Latex symbol selector
apt-get install libgtk2.0-dev libxml2-dev
# manually install latex symbol selector
echo "Manually install Latex symbol selector"

# Python
sudo apt-get install python-pip python-dev python-setuptools build-essential
sudo pip install the fuck
sudo pip install csvkit

# Rio
wget https://raw.githubusercontent.com/jeroenjanssens/data-science-at-the-command-line/master/tools/Rio
echo "Set-up Rio"

# JSON
sudo apt-get install jq
sudo apt-get install lmagemagick # display
