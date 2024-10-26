#!/bin/bash
mkdir -p download
wget -O download/vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo gdebi -n download/vscode.deb
rm download/vscode.deb
