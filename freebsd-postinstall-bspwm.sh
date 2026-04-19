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
  bat btop bspwm chromium dbus dunst eza fastfetch feh firefox \
  fish ghostty git gvfs lm-sensors neovim nsxiv \
  numlockx nwg-look picom polybar polkit-gnome  py311-trash-cli rofi \
  sddm starship stow sxhkd thunar thunar-archive-plugin \
  tree unzip vim xarchiver xclip xdg-user-dirs xorg xorg-apps \
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
xdg-user-dirs-update

echo "==> Stowing dotfiles..."
if [ -d "$HOME/.dotbsd" ]; then
  cd "$HOME/.dotbsd"
  stow \
    bat bin bspwm btop fastfetch fish fonts \
    ghostty icons nsxiv nvim scripts starship themes \
    vim wallpaper yazi zathura
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
sudo chsh -s /usr/local/bin/fish "$USER" && echo "Wyloguj się, aby zastosować nową powłokę"

echo "==> Done! Uruchom ponownie: sudo reboot"
