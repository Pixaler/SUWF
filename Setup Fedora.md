21.05.2023 20:28

***Links:***

***Sources:***
- [Fedora Zero](https://plafon.gitbook.io/fedora-zero/fedora-zero/v-samom-nachale-...)
- [proffix4/dev_for_fedora](https://github.com/proffix4/dev_for_fedora)
- [devangshekhawat/Fedora-39-Post-Install-Guide](https://github.com/devangshekhawat/Fedora-39-Post-Install-Guide) 
***Timeline:***
- Updated to Fedora 39

# Fixes To Add
- Updated guide(https://github.com/devangshekhawat/Fedora-39-Post-Install-Guide)
- Setup JACK for Reaper
```
sudo dnf install pipewire-jack-audio-connection-kit --allowerasing
```
 - [Audio setup](https://github.com/brendaningram/linux-audio-setup-scripts/blob/main/fedora/38/install-audio.sh)




# Installation
# Mount disks
### In Gnome Disks
- User Session Defaults = False
- Show in user interface = True
- Mount options = exec, permissions, auto,x-gvfs-show
- Mount Point = /mnt/storage
- Identify As = /dev/sda1
- Filesystem Type = ntfs-3g
### Mount disk
### In terminal 
```
sudo chown -R pixaler:pixaler /mnt/storage
```
# dnf config
- sudo gnome-text-editor /etc/dnf/dnf.conf
```
fastestmirror=True
max_parallel_downloads=10
defaultyes=True
keepcache=True
deltarpm=True
```


# Add RPM Fusion
```
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```
```
sudo dnf autoremove && sudo dnf clean all && sudo dnf groupupdate core
```
# System settings
- Apperance - Dark theme
- Notifications - Disable for Reporting Problems
- Bluetooth = False
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
  - Add "Switch windows" - Alt+Tab
- Region - Change formats to United Kingdom

# Update system
**In tty (Ctrl+Alt+F3)**
```
sudo dnf update && sudo dnf upgrade --refresh -y && reboot
```

# Codecs
```bash
sudo dnf groupupdate 'core' 'multimedia' 'sound-and-video' --setop='install_weak_deps=False' --exclude='PackageKit-gstreamer-plugin' --allowerasing && sync
sudo dnf swap 'ffmpeg-free' 'ffmpeg' --allowerasing
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg
sudo dnf install lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia
```

# far2l
```
sudo dnf copr enable polter/far2l -y
sudo dnf install far2l -y
```

# Gnome Tweaks

- https://github.com/lassekongo83/adw-gtk3/releases/tag/v5.2
Download archive and put to ~/.local/share/themes
```
sudo dnf install papirus-icon-theme -y
sudo dnf install gnome-tweaks -y
```
- Appearance
    - Adwaita-dark
    - Papirus Icons
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

# Gnome Extensions
```
flatpak install flathub com.mattjakeman.ExtensionManager
```
- Dash to panel
  - Visible taskbar only and centred
  - App Icon Margin = 2px
  - Ungroup apllications
    - Unpin apps
  - Keep original gnome-shell top panel
- ArcMenu
  - Change to K-runner style
- Status Area Horizontal Spacing
- Caffeine
    - Disable notifications
- Vitals
- AppIndicator and KStatusNotifierItem Support
- Auto select headset
- Just perfection
	- Disable: Activities Button, App Menu, Accessibility Menu
	- Startup behavior: Desktop

# Neovim
```
sudo dnf install clipman neovim nodejs npm gcc-c++ -y
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim 
nvim
```

# Terminal

## Dependencies
```
sudo dnf install alacritty util-linux-user fish inxi htop neofetch grubby eza -y
```
## Fish
```
grep tecmint /etc/passwd
chsh -s $(which fish)
grep tecmint /etc/passwd
```

# Apps
## Restore backups
## Enable flathub
```
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```
## Restore flatpak apps
```
flatpak install flathub -y (cat flatpaks.txt)
```
## Vivaldi portable
```
xdg-settings set default-web-browser Vivaldi.desktop
```


# Coding

## Git
```
find /mnt/storage/07_Projects/ -name '.git' -exec bash -c 'git config --global --add safe.directory ${0%/.git}' {} \;
sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit -y
git config --global user.name "Pixaler"
git config --global user.email "gnidko02@gmail.com"
```

## Android
```
sudo dnf install android-tools
```

## Python
```
sudo dnf install pip
```
### In project folder 
```
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

# Optimization
## Update rtc time for dual boot
```
sudo timedatectl set-local-rtc '0'
```

## Improve battery life
```
 sudo dnf install tlp tlp-rdw
 sudo systemctl mask power-profiles-daemon
 sudo dnf install powertop
 sudo powertop --auto-tune
```
## H/W Video accelaration
```
 sudo dnf install ffmpeg ffmpeg-libs libva libva-utils
 sudo dnf install intel-media-driver
```

## Disable mitigations
- Increase old CPU perfomance
```
sudo grubby --update-kernel=ALL --args="mitigations=off"
```
## Modern standby
```
sudo grubby --update-kernel=ALL --args="mem_sleep_default=s2idle"
```
## Speed up startup
```
sudo systemctl disable NetworkManager-wait-online.service
sudo rm /etc/xdg/autostart/org.gnome.Software.desktop
```
# Kernel 

0. Prevent installation kernel from dnf. In /etc/sysconfig/kernel
```
UPDATEDEFAULT=no
```
1. Install package
```
sudo dnf install patch gcc ncurses-devel make flex bison openssl-devel openssl perl dwarves elfutils-libelf-devel -y
sudo dnf install fedpkg fedora-packager rpmdevtools ncurses-devel pesign grubby -y
```
2. Download kernel [Vanila](https://kernel.org/), [Xanmod](https://xanmod.org/)
```
cd <kernel_source_folder>
make mrproper
```
3. Tweaks and patch
- Patch for CPU. In kernel source folder. For vanilla kernel.
```
wget https://raw.githubusercontent.com/graysky2/kernel_compiler_patch/master/more-uarches-for-kernel-6.8-rc4%2B.patch 
patch -p1 < more-uarches-for-kernel-6.8-rc4+.patch
make menuconfig
```
And choose your cpu and save config

![[Improving Radeon 520 perfomace on Linux#In kernel source]]

- Disable in .config
  CONFIG_DEBUG_INFO_BTF
```
make -j8 binrpm-pkg
```  
- Install rpms
```
sudo make modules_install
```


# Video cards

## Enable AMDGPU drivers

- sudo nvim /etc/default/grub

```
GRUB_CMDLINE_LINUX="<options> amdgpu.ppfeaturemask=0xffffffff radeon.si_support=0 amdgpu.si_support=1"
```

- sudo grub2-mkconfig -o /boot/grub2/grub.cfg
- sudo reboot

## Corectrl and monitoring
- sudo dnf install corectrl mangohud goverlay -y
- sudo nano /etc/polkit-1/rules.d/90-corectrl.rules

```c
polkit.addRule(function(action, subject) {
      if ((action.id == "org.corectrl.helper.init" ||
           action.id == "org.corectrl.helperkiller.init") &&
          subject.local == true &&
          subject.active == true &&
          subject.isInGroup("pixaler")) {
              return polkit.Result.YES;
      }
  });
```

![[Install and setup Flatpak apps ]]
