echo "I try this s#*@"
sudo apt update
sudo apt upgrade
sudo apt install snap
echo "This is you term"
sudo apt install cool-retro-term
sudo snap install nvim --classic
echo "some progers stuff"
sudo apt install python3
sudo apt install python3-venv

#gcc
sudo apt-get install build-essential
#clang
sudo apt-get install clang
sudo snap install clangd --classic
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 16
rm llvm.sh
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-16 100
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-16 100
sudo update-alternatives --config cc

sudo apt install cpputest
sudo apt install valgrind
sudo apt install cmake
echo "some programs"
sudo apt install brasero
sudo apt install gimp
echo "I'l do it mother #@%#$"
