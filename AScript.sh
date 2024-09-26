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

echo "now Astro config"
sudo rm ~/.config/nvim/lua/plugins/configs/notify.lua
sudo echo "local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match(\"warning: multiple different client offset_encodings\") then
        return
    end

    notify(msg, ...)
end" >> ~/.config/nvim/lua/plugins/configs/notify.lua

sed -i "s/relativenumber = true/relativenumber = false/g" ~/.config/nvim/lua/astronvim/options.lua

echo "Done!"
