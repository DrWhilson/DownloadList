echo "Ok now fonts"
#sudo cp ./3270.zip /usr/local/share/fonts
#sudo unzip /usr/local/share/fonts/3270.zip
#sudo rm /usr/local/share/fonts/3270.zip
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
