#!/bin/bash
echo "I try this ;~;"
if [[ "$1" == "Ubuntu" ]]; then
  sudo apt update
  sudo apt upgrade
  sudo apt-get install neofetch
  sudo apt install snap

  echo "This is you term"
  sudo snap install nvim --classic

  echo "some progers stuff"
  sudo apt install python3
  sudo apt install python3-venv
  sudo apt-get install build-essential
  sudo apt install cmake

  if [[ "$2" == "full" ]]; then
    sudo apt install valgrind
    sudo apt install libstdc++-12-dev
    sudo update-alternatives --config cc
    echo "Install GTest"
    sudo apt-get install libgtest-dev
    cd /usr/src/gtest
    sudo cmake CMakeLists.txt
    sudo make
    cd ./lib
    sudo cp *.a /usr/lib
  else 
    echo "Some pac skipepd. Use full to install it"
  fi
  
  echo "Some programs"
  # sudo apt install brasero
  sudo apt install gimp
  sudo apt install telegram-desktop
  sudo snap install discord
  neofetch
elif [[ "$1" == "Arch" ]]; then
  sudo pacman -Syu
  sudo pacman -S neofetch
  sudo pacman -S networkmanager

  echo "This is you term"
  sudo pacman -S neovim

  echo "Some progers stuff"
  sudo pacman -Sy base-devel wget
  pacman -Syu cmake

  echo "Some programs"
  # sudo pacman -S brasero
  sudo pacman -S gimp
  sudo pacman -S telegram-desktop
  sudo pacman -S firefox
  sudo pacman -S discord
  neofetch
else
  echo "Set system as param: Ubuntu or Arch"
  exit
fi
echo "Ok, I do it another time"
