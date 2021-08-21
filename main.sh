#!/usr/bin/bash


# installing all needed packages
packagesNeeded = "neovim git npm firefox alacritty lxsession picom networkmanager volumeicon conky trayer nitrogen xmonad xmobar scratchpad qalculate-gtk dmenu fish code discord"
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
  sudo pacman -S $packagesNeeded
else echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: $packagesNeeded">&2; fi


# installing kyoto.nvim
if test -d "~/.config/nvim"; then
  mv ~/.config/nvim ~/.config/nvim.bak
  mv ~/.local/share/nvim ~/.local/share/nvim.bak
else 
  mkdir "~/.config/nvim"
fi
git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone https://github.com/samrath2007/kyoto.nvim ~/.config/nvim
mkdir ~/.config/nvim/lua/kyotorc
touch ~/.config/nvim/lua/kyotorc/init.lua
nvim +"lua require'pluginList'; require'packer'.sync()"

# backing up xmonad
if test -d "~/.xmonad"; then
  mv "~/.xmonad" "~/.xmonad.old"
else 
  mkdir "~/.xmonad"
fi

# installing xmonad
cp -R "./xmonad" "~/.xmonad"

# backing up xmobar
if test -d "~/.config/xmobar"; then
  mv "~/.config/xmobar" "~/.config/xmobar.old"
else 
  mkdir "~/.xmonad"
fi

# installing xmobar
cp -R "./xmobar" "~/.config/xmobar"

# backing up zshrc
if test -f "~/.zshrc"; then
  mv "~/.zshrc" "~/.zshrc.bak"
fi

# updating zshrc
cp "./zshrc" "~/.zshrc"

# setting fish configs
mkdir "~/.config/fish"
cp -R "./fish" "~/.config/fish"

# setting up fonts
mkdir "~/.fonts"
cp -R "./fonts" "~/.fonts"

# set up scripts
mkdir "~/.scripts"
cp -R "./scripts" "~/.scripts"

# set up alacritty
if test -d "~/.config/alacritty"; then
  mv "~/.config/alacritty" "~/.config/alacritty.old"
else
  mkdir "~/.config/alacritty"
fi
cp "./alacritty.yml" "~/.config/alacritty/alacritty.yml"








