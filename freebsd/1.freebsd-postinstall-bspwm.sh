#!/usr/bin/env bash

set -euo pipefail

# === Jednorazowe sudo — odświeżaj token co 60s w tle ===
echo "==> Podaj hasło sudo (jednorazowo)..."
sudo -v
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

echo "==> Updating pkg repos..."
sudo pkg update -f

echo "==> Installing packages..."
sudo pkg install -y \
  bat btop bspwm chromium clipmenu dbus dunst eza fastfetch feh firefox \
  fish ghostty git gthumb gvfs kitty neovim nsxiv \
  numlockx nwg-look picom polybar polkit-gnome py311-trash-cli rofi \
  sddm starship stow sxhkd thunar thunar-archive-plugin \
  tree unzip vim xarchiver xclip xdg-user-dirs xdotool xorg xorg-apps \
  xorg-drivers xorg-fonts xinit xsetroot xrandr yazi \
  zathura zoxide

echo "==> Enabling dbus (required by Xorg/GTK/Qt)..."
sudo sysrc dbus_enable="YES"
sudo service dbus start || true

echo "==> Adding user to groups..."
for group in video wheel audio operator dialog; do
  sudo pw groupmod "$group" -m "$USER" 2>/dev/null || true
done

echo "==> Enabling SDDM..."
sudo sysrc sddm_enable="YES"

echo "==> Updating XDG user dirs..."
env LANG=pl_PL.UTF-8 xdg-user-dirs-update --force

echo "==> backup .profie..."
cp ~/.profile ~/.profile.bak

echo "==> set to pl keyboard..."
sudo mkdir -p /usr/local/etc/X11/xorg.conf.d
cp ~/.dotbsd/freebsd/usr/local/etc/X11/xorg.conf.d/00-keyboard.conf /usr/local/etc/X11/xorg.conf.d/00-keyboard.conf

echo "==> Stowing dotfiles..."
if [ -d "$HOME/.dotbsd" ]; then
  cd "$HOME/.dotbsd"
  stow \
    bat bin bspwm btop fastfetch fish fonts \
    ghostty icons kitty nsxiv nvim profile scripts shrc starship themes \
    vim wallpaper xprofile xinitrc yazi zathura
else
  echo "!! Directory ~/.dotbsd not found, skipping stow"
fi

echo "==> Installing bspwm tabbed..."
if [ -d "$HOME/.config/bspwm/tabbed" ]; then
  cd "$HOME/.config/bspwm/tabbed"
  sudo make clean install
else
  echo "!! tabbed directory not found, skipping"
fi

echo "==> Change shell to fish..."
su -
sudo echo "/usr/local/bin/fish" >>/etc/shells
sudo pwd_mkdb -p /etc/master.passwd
sudo pw usermod $USER -s /usr/local/bin/fish
# sudo chsh -s /usr/local/bin/fish "$USER" && echo "Wyloguj się, aby zastosować nową powłokę"

echo "==> Done! Uruchom ponownie: sudo reboot"
