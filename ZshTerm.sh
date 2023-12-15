#!/bin/bash
echo "Ok, cool terminal"
if [[ "$1" == "Ubuntu" ]]; then 
  sudo apt install zsh
  sudo apt install curl
elif [[ "$1" == "Arch" ]]; then
  sudo pacman -S zsh
  sudo pacman -S curl
else
  echo "Set system as param: Ubuntu or Arch" 
  exit
fi

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sed '/plugins/d' ~/.zshrc
echo 'plugins=(git zsh-syntax-highlighting)' >>~/.zshrc

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc
echo 'POWERLEVEL9K_MODE="nerdfont-complete"' >> ~/.zshrc
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
