#!/bin/bash
mkdir -p download
wget -O download/google-chrome-stable_current_amd64.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
sudo gdebi -n download/google-chrome-stable_current_amd64.deb
rm download/google-chrome-stable_current_amd64.deb
