#!/usr/bin/bash
printf "Please state the user's home directory name:"
read USERNAME

# installing all needed packages
packagesNeeded="neovim git npm firefox alacritty lxsession picom networkmanager volumeicon trayer nitrogen xmonad xmobar qalculate-gtk dmenu fish code discord"
if test -x "$(command -v apk)" ;       then 
  echo "apk package manager detected. using that to install packages."
  sudo apk update
  sudo apk add --no-cache $packagesNeeded
elif test -x "$(command -v apt-get)" ; then 
  echo "apt-get package manager detected. using that to install packages."
  sudo apt-get update
  sudo apt-get install $packagesNeeded
elif test -x "$(command -v dnf)" ;     then 
  echo "dnf package manager detected. using that to install packages."
  sudo dnf check-update
  sudo dnf install $packagesNeeded
elif test -x "$(command -v zypper)" ;  then 
  echo "zypper package manager detected. using that to install packages."
  sudo zypper refresh
  sudo zypper install $packagesNeeded
elif test -x "$(command -v pacman)" ; then 
  echo "pacman package manager detected. using that to install packages."
  sudo pacman -Syy
  sudo pacman -S $packagesNeeded xmonad-contrib
else echo "FAILED TO INSTALL PACKAGES: Package manager not found. You must manually install: $packagesNeeded">&2; fi


# installing kyoto.nvim
if test -d "/home/$USERNAME/.config/nvim"; then
  mv /home/$USERNAME/.config/nvim /home/$USERNAME/.config/nvim.bak
  mv /home/$USERNAME/.local/share/nvim /home/$USERNAME/.local/share/nvim.bak
else 
  mkdir "/home/$USERNAME/.config/nvim"
fi
git clone https://github.com/wbthomason/packer.nvim /home/$USERNAME/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone https://github.com/samrath2007/kyoto.nvim /home/$USERNAME/.config/nvim
mkdir /home/$USERNAME/.config/nvim/lua/kyotorc
touch /home/$USERNAME/.config/nvim/lua/kyotorc/init.lua
nvim +"lua require'pluginList'; require'packer'.sync()"

# backing up xmonad
if test -d "/home/$USERNAME/.xmonad"; then
  mv "/home/$USERNAME/.xmonad" "/home/$USERNAME/.xmonad.old"
else 
  mkdir "/home/$USERNAME/.xmonad"
fi

# installing xmonad
cp -R "./xmonad" "/home/$USERNAME/.xmonad"

# backing up xmobar
if test -d "/home/$USERNAME/.config/xmobar"; then
  mv "/home/$USERNAME/.config/xmobar" "/home/$USERNAME/.config/xmobar.old"
else 
  mkdir "/home/$USERNAME/.xmobar"
fi

# installing xmobar
cp -R "./xmobar" "/home/$USERNAME/.config/xmobar"

# backing up zshrc
if test -f "/home/$USERNAME/.zshrc"; then
  mv "/home/$USERNAME/.zshrc" "/home/$USERNAME/.zshrc.bak"
fi

# updating zshrc
cp "./zshrc" "/home/$USERNAME/.zshrc"

# setting fish configs
mkdir "/home/$USERNAME/.config/fish"
cp -R "./fish" "/home/$USERNAME/.config/fish"

# setting up fonts
mkdir "/home/$USERNAME/.fonts"
cp -R "./fonts" "/home/$USERNAME/.fonts"

# set up scripts
mkdir "/home/$USERNAME/.scripts"
cp -R "./scripts" "/home/$USERNAME/.scripts"

# set up alacritty
if test -d "/home/$USERNAME/.config/alacritty"; then
  mv "/home/$USERNAME/.config/alacritty" "/home/$USERNAME/.config/alacritty.old"
fi
mkdir "/home/$USERNAME/.config/alacritty"
cp "./alacritty.yml" "/home/$USERNAME/.config/alacritty/alacritty.yml"








