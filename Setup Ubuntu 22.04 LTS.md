16.05.2023 13:25

***Links:***

***Sources:*** 

# Update system

## Remove Ubuntu Pro ads
```
sudo rm /etc/apt/apt.conf.d/20apt-esm-hook.conf
```
## Update system 
```
sudo apt update && sudo apt dist-upgrade -y
sudo reboot
```
# Disk
```
sudo apt install ntfs-3g
echo "/dev/sda1 /mnt/storage ntfs-3g nosuid,nodev,nofail,x-gvfs-show 0 0" | sudo tee -a /etc/fstab
```
# System settings
- Bluetooth = False
- Appearance = Dark
- Sound
  - Over-Amplification = True
  - System Sounds = False
- Power
	- Screen Blank = 15min
	- Dim Screen = False
- Touchpad = False
- Keyboard
	- Add layouts
	- Change "Run comand" shortcut to Shift+Alt+F2
- Region - Change formats to United Kingdom

# far2l
```
sudo add-apt-repository ppa:far2l-team/ppa -y
sudo apt update
sudo apt install far2l -y
```

# Gnome Tweaks
```
sudo apt install gnome-tweaks -y
```
- Fonts
  - Scaling Factor = 1.10
- Keyboard & Mouse 
  - Switching to another layout = Capslock
- Top Bar
  - Weekday, Seconds = True
- Window Titlebars 
  - Maximize = True
- Windows
  - Center New Windows = True
- Add far2l to startup

# Flatpak
```
sudo apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

# Gnome Extensions
- Dash to panel - Set settings when disabled
  - Visible taskbar only and centred
  - App Icon Margin = 2px
  - Ungroup apllications
	  - Unpin apps
  - Keep original gnome-shell top panel
- Status Area Horizontal Spacing
- Caffeine
	- Disable notifications
- Vitals
	- Align to Left
- AppIndicator and KStatusNotifierItem Support 
- Just Perfection
	- Disable Activities button, App Menu, Accessibility Menu
	- Startup Status - Desktop
- ArcMenu
	- Layout - Runner

# Terminal

## Software
```
sudo apt install htop exa tmux curl -y
```
![[Configure Fish shell#Ubuntu]]
![[Configure Fish shell#Change to default]]

## Alacritty
```
sudo apt install fish -y
```
 
## Lazygit 
```
set LAZYGIT_VERSION (curl -s "https://api.github.com/repos
/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_{$LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo mkdir /usr/local/bin
sudo install lazygit /usr/local/bin
```


# Nvim

## Dependencies
```
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install nodejs -y
sudo apt install python3-venv -y
```
## Install neovim
```
sudo mkdir /usr/local/bin
curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o nvim
sudo install nvim /usr/local/bin
```

## packer.nvim
```
 git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```
- nvim 
  
# Coding
## Git
```
find /mnt/storage/07_Projects/ -name '.git' -exec bash -c 'git config --global --add safe.directory ${0%/.git}' {} \;
git config --global user.name "Pixaler"
git config --global user.email "gnidko02@gmail.com"
```
## Python
```
sudo apt install python3-venv python3-pip python-is-python3
sudo apt install python3-tk
```

# Kernel

## Stop updating kernel
```
sudo apt-mark hold linux-image-generic linux-headers-generic
```

## Ubuntu kernel
- sudo apt-get build-dep linux-image-$(uname -r)
- sudo apt install build-essential libncurses5-dev fakeroot xz-utils libelf-dev bison flex dwarves
- cp /boot/config-$(uname -r) .config
- In .config
```
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_REVOCATION_KEYS=""

CONFIG_DEBUG_INFO=n
CONFIG_DEBUG_INFO_DWARF5=n
CONFIG_DEBUG_INFO_BTF=n
```
- make -j8 bindeb-pkg


## Vanila kernel
- sudo apt install gcc make build-essential libncurses5-dev fakeroot xz-utils libelf-dev libssl-dev bison flex dwarves debhelper -y
- Download and extract
- make menuconfig
- In .config
```
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_REVOCATION_KEYS=""

CONFIG_DEBUG_INFO=n
CONFIG_DEBUG_INFO_DWARF5=n
CONFIG_DEBUG_INFO_BTF=n
```
- make -j8 bindeb-pkg
