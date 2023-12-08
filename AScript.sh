echo "Ok now fonts"
mkdir buff
mv ./3270.zip ./buff/3270.zip
cd ./buff
sudo unzip 3270.zip
mv ./3270.zip ../3270.zip
cd ..
sudo mv ./buff/* /usr/local/share/fonts/
sudo rm -r ./buff
echo "Now GIT"
mkdir ./.config/nvim
git clone --depth=1 https://github.com/AstroNvim/AstroNvim.git ~/.config/nvim/
sudo rm ~/.config/nvim/lua/plugins/configs/notify.lua
sudo echo "local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match(\"warning: multiple different client offset_encodings\") then
        return
    end

    notify(msg, ...)
end" >> ~/.config/nvim/lua/plugins/configs/notify.lua
echo "Done!"

sed -i "s/relativenumber = true/relativenumber = false/g" ~/.config/nvim/lua/astronvim/options.lua
