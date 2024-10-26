#!/bin/bash

work_dir=$(pwd)
mkdir -p ~/projects
cd ~/projects

if [ -d "./grub2-themes-2024-08-19" ]; then
  echo "La carpeta grub2-themes-2024-08-19 ya existe."
else
  wget https://github.com/vinceliuice/grub2-themes/archive/refs/tags/2024-08-19.zip
  unzip -q 2024-08-19.zip
  rm 2024-08-19.zip
fi

cd grub2-themes-2024-08-19 
sudo ./install.sh -i color -t vimix
cd $work_dir
