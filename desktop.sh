#!/bin/bash

set -e

sudo xbps-install -Suvy

sudo xbps-install -Sy void-repo-nonfree

sudo xbps-install -Sy dbus kde5 kde5-baseapps plasma-disks plasma-firewall plasma-wayland-protocols plasma-systemmonitor mesa-dri xdg-user-dirs xorg xorg-fonts xorg-server-xwayland autox elogind xf86-video-intel qt5-wayland

sudo xbps-install -Sy alsa-utils alsa-firmware alsa-tools alsa-pipewire apulse bluez-alsa ffmpeg alsa-plugins-ffmpeg pipewire pavucontrol

sudo xbps-install -Sy firefox neofetch vlc ntfs-3g nano

### pipewire alsa itegration
sudo mkdir -p /etc/alsa/conf.d
sudo ln -s /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d
sudo ln -s /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d

sudo ln -s /usr/share/applications/pipewire.desktop /etc/xdg/autostart/pipewire.desktop
sudo ln -s /usr/share/applications/pipewire-pulse.desktop /etc/xdg/autostart/pipewire-pulse.desktop

sudo ln -s /etc/sv/NetworkManager /var/service
sudo ln -s /etc/sv/alsa /var/service

sudo ln -s /etc/sv/sddm /etc/runit/runsvdir/default/
sudo ln -s /etc/sv/dbus /etc/runit/runsvdir/default/

sleep 5
sudo reboot
