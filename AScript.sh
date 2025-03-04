#!/bin/bash
echo "Ok now fonts"
unzip ./3270.zip -d ./3270
mv ./3270/*ttf ~/.local/share/fonts/
rm -r ./3270
fc-cache -f -v

echo "Now GIT"
sudo rm -r ~/.config/nvim

git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
rm -rf ~/.config/nvim/.git

sed -i 's/if true/-- if true/g' ~/.config/nvim/lua/plugins/astrocore.lua
sed -i 's/relativenumber = true/relativenumber = false/g' ~/.config/nvim/lua/plugins/astrocore.lua

echo "Done!"
