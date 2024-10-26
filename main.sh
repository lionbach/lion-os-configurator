#!/bin/bash

# Funciones

text_box(){
  echo
  echo "--------------------------------------------------"
  echo "-- $1"
  echo "--------------------------------------------------"
  echo
}

install_chrome() {
  text_box 'Install Google Chrome'
  local pkgName="google-chrome-stable"
  local isInstalled=$(apt-mark showinstall | grep -q "^$pkgName$" && echo "y" || echo "n")
  if [ $isInstalled == "y" ]; then
    echo "$pkgName ya esta instalado"
  else
    mkdir -p download
    wget -O download/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo gdebi download/google-chrome-stable_current_amd64.deb
    echo
    echo "--------------------------------------------------"
    echo "Complete estos pasos:"
    echo "01 - Iniciar sesion en su cuenta de Google (Principal)"
    echo "       Activar la sincronizacion"
    echo "         Configuracion"
    echo "           administrar los datos de la sincronizacion"
    echo "             Personalizar la sincronizacion"
    echo "               Desactivamos: Contraseñas y llaves de acceso"
    echo "               Desactivamos: Direcciones y mas"
    echo "               Desactivamos: Formas de pago, ofertas y direcciones con Google Pay"
    echo "             atras y confirmar"
    echo
    echo "02 - Iniciar sesion en extencion de Bitwarden"
    echo
    echo "03 - Iniciar sesion en su cuenta de Google (Secundaria)"
    echo "       ¿Deseas continuar en un nuevo perfil de Chrome?"
    echo "         No, gracias"
    echo
    echo "04 - <Iniciar sesion en su cuenta de Github"
    echo "--------------------------------------------------"
    echo
    read -p "Enter para continuar..."
  fi
}

install_git() {
  text_box 'Install Git'
  local pkgName="git"
  local isInstalled=$(apt-mark showinstall | grep -q "^$pkgName$" && echo "y" || echo "n")
  if [ $isInstalled == "y" ]; then
    echo "$pkgName ya esta instalado"
  else
    sudo apt -y install git
    git config --global user.name   "lionbach"
    git config --global user.email  "leomumbach@gmail.com"
    git config --global core.editor "nano"
    #For Linux:
    git config --global core.autocrlf input
    #For Windows:
    #git config --global core.autocrlf input
    create_ssh_key
    get_ssh_key
  fi
}

create_ssh_key() {
  if [ -f ~/.ssh/id_rsa.pub ]; then
    echo "Clave ~/.ssh/id_rsa.pub ya existe"
  elif [ -f ~/.ssh/id_ed25519.pub ]; then
    echo "Clave ~/.ssh/id_ed25519.pub ya existe"
  else
    # No borrar las lineas vacias, ya que equivalen a apretar enter.
    ssh-keygen 2>/dev/null <<MSI

MSI
    echo "Clave SSH creada"
  fi
}

get_ssh_key() {
  if [ -f ~/.ssh/id_rsa.pub ]; then
    text_box "Agregue esta clave a su cuenta de github"
    echo "Clave publica SSH id_rsa.pub:"
    cat ~/.ssh/id_rsa.pub
  elif [ -f ~/.ssh/id_ed25519.pub ]; then
    text_box "Agregue esta clave a su cuenta de github"
    echo "Clave publica SSH id_ed25519.pub:"
    cat ~/.ssh/id_ed25519.pub
  else
    echo "No existe clave ssh"
  fi
  read -p "Enter para continuar..."
}

download_repo() {
  mkdir -p ~/projects
  cd ~/projects
  git clone git@github.com:lionbach/lion-os-configurator.git
  cd lion-os-configurator
  git status
}

# Flujo del script

sudo apt update
sudo apt install gdebi
install_chrome
install_git
download_repo
