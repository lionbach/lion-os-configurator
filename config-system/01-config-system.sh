#!/bin/bash

dir_files=(*)
dir_files_filter_content=()
dir_files_filter_title=()

for i in "${dir_files[@]}";do
  if [[ ${i:0:7} == "config " ]] && [[ ${i:(-3)} == ".sh" ]] && [[ -f "$i" ]];then
    dir_files_filter_content+=("$i")
    dir_files_filter_title+=("${i:7:-3}")
  fi
done

zenity_comand='zenity \
--list \
--title="Lionbach OS Configurator" \
--width=900 \
--height=600 \
--text="\n<span size='
zenity_comand+="'16pt'"
zenity_comand+='><b>Lionbach OS Configurator</b></span>\n\n<b>Configurar sistema.</b>\nSeleccion configuraciones a aplicar:\n" \
--separator=" " \
--checklist \
--column="" \
--column="Id" \
--column="Config" '

for i in "${!dir_files_filter_title[@]}"; do
  zenity_comand+=" 0 $i \"${dir_files_filter_title[$i]}\""
done

software_to_install=$(eval "$zenity_comand")
software_to_install_array=($software_to_install)
ans=$?

if [ $ans -eq 0 ];then
  for i in "${software_to_install_array[@]}";do
    eval "bash '${dir_files_filter_content[i]}'"
  done
fi
