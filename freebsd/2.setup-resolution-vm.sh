#!/bin/sh

# ===========================================
# Konfiguracja rozdzielczosci 1920x1080
# FreeBSD jako gość w virt-manager (QEMU/KVM)
# Wymagania: UEFI, karta Virtio lub VGA
# ===========================================

# Sprawdz czy uruchomiono jako root
if [ "$(id -u)" -ne 0 ]; then
  echo "BLAD: Uruchom skrypt jako root:"
  echo "  su -c 'sh setup-resolution-vm.sh'"
  exit 1
fi

echo "============================================"
echo " Konfiguracja 1920x1080 dla virt-manager"
echo "============================================"

# 1. Dodaj wpisy do /boot/loader.conf
echo ""
echo "[1/2] Aktualizacja /boot/loader.conf..."

if grep -q "efi_max_resolution" /boot/loader.conf; then
  echo "      Wpisy juz istnieja, pomijam."
else
  cat >>/boot/loader.conf <<'LOADER'
kern.vty=vt
hw.vga.textmode=0
efi_max_resolution="1920x1080"
LOADER
  echo "      Dodano wpisy do /boot/loader.conf"
fi

# 2. Utworz katalog xorg.conf.d jesli nie istnieje
echo ""
echo "[2/2] Tworzenie konfiguracji Xorg..."

mkdir -p /usr/local/etc/X11/xorg.conf.d

cat >/usr/local/etc/X11/xorg.conf.d/10-video.conf <<'XORG'
Section "Device"
    Identifier "Card0"
    Driver "scfb"
EndSection

Section "Screen"
    Identifier "Screen0"
    Device "Card0"
    DefaultDepth 24
    SubSection "Display"
        Depth 24
        Modes "1920x1080"
    EndSubSection
EndSection
XORG

# Podsumowanie
echo ""
echo "============================================"
echo " Gotowe! Uruchom ponownie system:"
echo "   reboot"
echo "============================================"
