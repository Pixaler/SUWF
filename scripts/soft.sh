# far2l
sudo add-apt-repository ppa:far2l-team/ppa -y
sudo apt update
sudo apt install far2l -y

# Flapaks
sudo apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# Install flatpaks
xargs flatpak install flathub -y < flatpaks.txt

# Console soft
sudo apt install htop exa tmux curl -y

# fish
sudo apt install fish -y
# Set fish as a defult shell
grep tecmint /etc/passwd
chsh -s $(which fish)
grep tecmint /etc/passwd

# Lazygit
set LAZYGIT_VERSION (curl -s "https://api.github.com/repos
/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_{$LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo mkdir /usr/local/bin
sudo install lazygit /usr/local/bin

# Nvim
## Dependencies
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install nodejs -y
sudo apt install python3-venv -y

## Install neovim
sudo mkdir /usr/local/bin
curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o nvim
sudo install nvim /usr/local/bin

## packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
