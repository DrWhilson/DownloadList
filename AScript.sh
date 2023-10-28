echo "Ok now fonts"
sudo cp ./3270.zip /usr/local/share/fonts
sudo unzip /usr/local/share/fonts/3270.zip
sudo rm /usr/local/share/fonts/3270.zip
echo "Now GIT"
mkdir ./.config/nvim
git clone https://github.com/AstroNvim/AstroNvim.git ./.config/nvim/
