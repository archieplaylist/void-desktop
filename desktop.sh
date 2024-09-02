#!/bin/bash

# colors:
RED='\033[31m'
GREEN='\033[32m'
LGREEN='\033[1;32m'
NORMAL='\033[0m'
YELLOW='\033[33m'
LYELLOW='\033[1;33m'
LBLUE='\033[1;34m'
LMAGENTA='\033[1;35m'

if [[ $(whoami) != "root" ]]; then
    clear
    echo -e "${RED}You should execute this script as root user or via sudo <[*_*]>${NORMAL}"
    exit
fi

clear

echo -e "${LYELLOW}This script helps you to install DE and some useful programs on your ${LGREEN}Void Linux ${LYELLOW}:3\n${NORMAL}"

#Chroot questions
#========================================================
echo -e "${YELLOW}Did you install your system via chroot? ${NORMAL}[${GREEN}N${NORMAL}/${RED}y${NORMAL}]"
read
if [[ $REPLY = "no" || $REPLY = "n" || $REPLY = "N" || $REPLY = "No" || $REPLY = "" || $REPLY = " " ]]; then

    echo -e "${YELLOW}Do you want to update your xbps and update system? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
    read

    if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
        echo -e "${LBLUE}So I'll update your installed xbps now and install git${NORMAL}"
        echo -e "${LMAGENTA}----------------------------------------"
        xbps-install -Suy
        xbps-install -yu xbps
        xbps-install git curl wget bash-completion xtools -y
        echo -e "----------------------------------------${NORMAL}"
    fi
fi
#========================================================

#Swappiness
#========================================================
echo -e "${YELLOW}Do you want to set swappines to 10? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
read
if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
    echo -e "${LMAGENTA}----------------------------------------"
    sysctl vm.swappiness=10
    echo -e "----------------------------------------${NORMAL}"
fi
#========================================================

#multilib repo
#========================================================
echo -e "${YELLOW}Do you want to install multilib repo? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
read

if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
    echo -e "${LMAGENTA}----------------------------------------"
    xbps-install void-repo-multilib -y
    xbps-install -Syu
    echo -e "----------------------------------------${NORMAL}"
fi
#========================================================

#nonfree repo
#========================================================
echo -e "${YELLOW}Do you want to install nonfree repo? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
read

if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
    echo -e "${LMAGENTA}----------------------------------------"
    xbps-install void-repo-nonfree void-repo-multilib-nonfree -y
    xbps-install -Syu
    echo -e "----------------------------------------${NORMAL}"
fi
#========================================================

#DBus
#========================================================
echo -e "${YELLOW}Do you want to put dbus in autorun? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
read
if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
    echo -e "${LMAGENTA}----------------------------------------"
    ln -s /etc/sv/dbus /etc/runit/runsvdir/default/
    echo -e "----------------------------------------${NORMAL}"
fi
#========================================================

#Elogind
#========================================================
echo -e "${YELLOW}Do you want to install elogind? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
read

if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then

    echo -e "${LBLUE}Now I'll install elogind${NORMAL}"
    echo -e "${LMAGENTA}----------------------------------------"
    xbps-install elogind -y
    echo -e "----------------------------------------${NORMAL}"

    echo -e "${YELLOW}Do you want to put elogind in autorun? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
    read

    if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
        echo -e "${LMAGENTA}----------------------------------------"
        ln -s /etc/sv/elogind /etc/runit/runsvdir/default/
        echo -e "----------------------------------------${NORMAL}"
    fi

fi
#========================================================

#Desktop Environment
#========================================================
echo -e "${YELLOW}Do you want to install any DE? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
read

if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then

    echo -e "${YELLOW}Which DE you want to install ${LMAGENTA}(plasma, gnome, xfce4, cinnamon, mate, lxde, lxqt, openbox)${NORMAL}${YELLOW}?${NORMAL}"
    read

    #PLASMA
    #=========================================================
    if [[ $REPLY = "plasma" ]]; then

        echo -e "\n${LBLUE}So, I'll install KDE for you :3${NORMAL}"
        echo -e "${LMAGENTA}----------------------------------------"
        xbps-install kde5 -y
        echo -e "----------------------------------------${NORMAL}"

        echo -e "${YELLOW}Do you want to install kde5-baseapps? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
        read

        if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
            echo -e "${LBLUE}Alright, I'll install base kde apps${NORMAL}"
            echo -e "${LMAGENTA}----------------------------------------"
            xbps-install kde5-baseapps ark \
                            plasma-disks plasma-firewall plasma-systemmonitor \
                            kdegraphics-thumbnailers ffmpegthumbs \
                            xdg-user-dirs xdg-desktop-portal-kde \
                            xorg xorg-fonts xorg-server-xwayland \
                            mesa-dri xf86-video-intel plasma-wayland-protocols \
                            qt5-wayland qt6-wayland -y
            echo -e "----------------------------------------${NORMAL}"
        fi

        echo -e "${YELLOW}Do you want to install sddm? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
        read

        if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
            echo -e "${LMAGENTA}----------------------------------------"
            xbps-install -y sddm ntp
            ln -s /etc/sv/ntpd /var/service
            ln -s /etc/sv/sddm /etc/runit/runsvdir/default
            echo -e "----------------------------------------${NORMAL}"
        else

            echo -e "${LYELLOW}If you want to install another DM, you can enter the exact package name (or enter 'NO' for skip)"
            echo -e "You can find your DM by 'xbps-query -Rs <pkg name>' ;)${NORMAL}"
            read

            if [[ $REPLY != "NO" || $REPLY != "n" || $REPLY != "N" || $REPLY != "No" || $REPLY != "no" ]]; then
                echo -e "${LBLUE}So, I'll install ${REPLY} ${NORMAL}"
                echo -e "${LMAGENTA}----------------------------------------"
                xbps-install $REPLY -y
                ln -s /etc/sv/$REPLY /etc/runit/runsvdir/default/
                echo -e "----------------------------------------${NORMAL}"
            fi

        fi
    #========================================================

    #GNOME
    #========================================================
    elif [[ $REPLY = "gnome" ]]; then

        echo -e "\n${YELLOW}You can install ${GREEN}gnome${LMAGENTA}(includes base gnome apps)${YELLOW} or ${RED}gnome-core${YELLOW}. What you want to install? ${NORMAL}"
        read

        if [[ $REPLY = "gnome" ]]; then
            echo -e "${LBLUE}I'll install gnome${NORMAL}"
            echo -e "${LMAGENTA}----------------------------------------"
            xbps-install gnome gnome-browser-connector -y
            xbps-install xdg-desktop-portal xdg-dektop-portal-gnome \
                            xdg-user-dirs xdg-user-dirs-gtk xdg-utils
            echo -e "----------------------------------------${NORMAL}"

        elif [[ $REPLY = "gnome-core" ]]; then
            echo -e "${LBLUE}I'll install minimal gnome DE${NORMAL}"
            echo -e "${LMAGENTA}----------------------------------------"
            xbps-install gnome-core gnome-browser-connector -y
            xbps-install xdg-desktop-portal xdg-dektop-portal-gnome \
                            xdg-user-dirs xdg-user-dirs-gtk xdg-utils
            echo -e "----------------------------------------${NORMAL}"

        else
            echo -e "${RED}I don't know what is it :(${NORMAL}"
        fi

        echo -e "${YELLOW}Do you want to install gdm? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
        read

        if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
            echo -e "${LBLUE}Alright, I'll install gnome display manager${NORMAL}"
            echo -e "${LMAGENTA}----------------------------------------"
            xbps-install gdm -y
            ln -s /etc/sv/gdm /etc/runit/runsvdir/default/
            echo -e "----------------------------------------${NORMAL}"
        else
            echo -e "${LYELLOW}If you want to install another DM, you can enter the exact package name (or enter 'NO' for skip)"
            echo -e "You can find your DM by 'xbps-query -Rs <pkg name>' ;)${NORMAL}"
            read

            if [[ $REPLY != "NO" || $REPLY != "n" || $REPLY != "N" || $REPLY != "No" || $REPLY != "no" ]]; then
                echo -e "${LBLUE}So, I'll install ${REPLY} ${NORMAL}"
                echo -e "${LMAGENTA}----------------------------------------"
                xbps-install $REPLY -y
                ln -s /etc/sv/$REPLY /etc/runit/runsvdir/default/
                echo -e "----------------------------------------${NORMAL}"
            fi
        fi
    #========================================================

    #XFCE4
    #========================================================
    elif [[ $REPLY = "xfce4" ]]; then
        echo -e "\n${LBLUE}Now I'll install DM and XFCE for you :3${NORMAL}\n"

        echo -e "${YELLOW}Do you want to install lyDM? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
        read

        if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
            echo -e "${LBLUE}Alright, I'll install ly display manager${NORMAL}"
            echo -e "${LMAGENTA}----------------------------------------"
            xbps-install git zig libxcb-devel pam-devel cmatrix -y

            git clone https://github.com/fairyglade/ly
            cd ly
            zig build
            zig build installrunit

            ln -s /etc/sv/ly /etc/runit/runsvdir/default/
            rm /var/service/agetty-tty2
            cd ..
            echo -e "----------------------------------------${NORMAL}"
        else
            echo -e "${LYELLOW}If you want to install any DM if LyDM doesn't installed, you can enter the exact package name (or enter 'NO' for skip)"
            echo -e "You can find your DM by 'xbps-query -Rs <pkg name>' ;)${NORMAL}"
            read

            if [[ $REPLY != "NO" || $REPLY != "n" || $REPLY != "N" || $REPLY != "No" || $REPLY != "no" ]]; then
                echo -e "${LBLUE}So, I'll install ${REPLY} ${NORMAL}"
                echo -e "${LMAGENTA}----------------------------------------"
                xbps-install $REPLY -y
                ln -s /etc/sv/$REPLY /etc/runit/runsvdir/default/
                echo -e "----------------------------------------${NORMAL}"
            fi
        fi

        echo -e "${LBLUE}And finally I'll install XFCE(pkg)${NORMAL}"
        echo -e "${LMAGENTA}----------------------------------------"
        xbps-install xfce4 xfce4-whiskermenu-plugin xfce4-clipman-plugin xfce4-pulseaudio-plugin network-manager-applet \
            engrampa gvfs thunar-archive-plugin thunar-media-tags-plugin \
            xdg-user-dirs xorg xorg-fonts mesa-dri \
            papirus-icon-theme -y
        echo -e "----------------------------------------${NORMAL}"

    #========================================================

    #CINNAMON
    #========================================================
    elif [[ $REPLY = "cinnamon" ]]; then
        echo -e "\n${LBLUE}Now I'll install DM and CINNAMON for you :3${NORMAL}\n"

        echo -e "${YELLOW}Do you want to install lyDM? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
        read

        if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
            echo -e "${LBLUE}Alright, I'll install ly display manager${NORMAL}"
            echo -e "${LMAGENTA}----------------------------------------"
            xbps-install git zig libxcb-devel pam-devel cmatrix -y

            git clone https://github.com/fairyglade/ly
            cd ly
            zig build
            zig build installrunit

            ln -s /etc/sv/ly /etc/runit/runsvdir/default/
            rm /var/service/agetty-tty2
            cd ..
            echo -e "----------------------------------------${NORMAL}"
        else
            echo -e "${LYELLOW}If you want to install any DM if LyDM doesn't installed, you can enter the exact package name (or enter 'NO' for skip)"
            echo -e "You can find your DM by 'xbps-query -Rs <pkg name>' ;)${NORMAL}"
            read

            if [[ $REPLY != "NO" || $REPLY != "n" || $REPLY != "N" || $REPLY != "No" || $REPLY != "no" ]]; then
                echo -e "${LBLUE}So, I'll install ${REPLY} ${NORMAL}"
                echo -e "${LMAGENTA}----------------------------------------"
                xbps-install $REPLY -y
                ln -s /etc/sv/$REPLY /etc/runit/runsvdir/default/
                echo -e "----------------------------------------${NORMAL}"
            fi
        fi

        echo -e "${LBLUE}And finally I'll install XFCE(pkg)${NORMAL}"
        echo -e "${LMAGENTA}----------------------------------------"
        xbps-install cinnamon-all gnome-terminal network-manager-applet \
            engrampa gvfs \
            xdg-user-dirs xorg xorg-fonts mesa-dri \
            papirus-icon-theme -y
        echo -e "----------------------------------------${NORMAL}"

    #========================================================

    #MATE
    #========================================================
    elif [[ $REPLY = "mate" ]]; then
        echo -e "\n${LBLUE}Alright, I'll install Mate for you :3${NORMAL}\n"

        echo -e "${YELLOW}Do you want to install lyDM? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
        read

        if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
            echo -e "${LBLUE}Alright, I'll install ly display manager${NORMAL}"
            echo -e "${LMAGENTA}----------------------------------------"
            xbps-install git zig libxcb-devel pam-devel cmatrix -y

            git clone https://github.com/fairyglade/ly
            cd ly
            zig build
            zig build installrunit

            ln -s /etc/sv/ly /etc/runit/runsvdir/default/
            rm /var/service/agetty-tty2
            cd ..
            echo -e "----------------------------------------${NORMAL}"
        else
            echo -e "${LYELLOW}If you want to install any DM if LyDM doesn't installed, you can enter the exact package name (or enter 'NO' for skip)"
            echo -e "You can find your DM by 'xbps-query -Rs <pkg name>' ;)${NORMAL}"
            read

            if [[ $REPLY != "NO" || $REPLY != "n" || $REPLY != "N" || $REPLY != "No" || $REPLY != "no" ]]; then
                echo -e "${LBLUE}So, I'll install ${REPLY} ${NORMAL}"
                echo -e "${LMAGENTA}----------------------------------------"
                xbps-install $REPLY -y
                ln -s /etc/sv/$REPLY /etc/runit/runsvdir/default/
                echo -e "----------------------------------------${NORMAL}"
            fi
        fi

        echo -e "${LBLUE}Now I'll install Mate(pkg)"
        echo -e "${LMAGENTA}----------------------------------------"
        xbps-install mate -y
        echo -e "----------------------------------------${NORMAL}"
    #========================================================

    #LXDE
    #========================================================
    elif [[ $REPLY = "lxde" ]]; then
        echo -e "\n${LBLUE}So, now I'll install LXDE :3${NORMAL}\n"

        echo -e "${YELLOW}Do you want to install LXDM? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
        read

        if [[ $REPLY = "no" || $REPLY = "n" || $REPLY = "N" || $REPLY = "No" ]]; then
            echo -e "${LYELLOW}If you want to install any DM, you can enter the exact package name (or enter 'NO' for skip)"
            echo -e "You can find your DM by 'xbps-query -Rs <pkg name>' ;)${NORMAL}"
            read

            if [[ $REPLY != "NO" ]]; then
                echo -e "${LBLUE}So, I'll install ${REPLY} ${NORMAL}"
                echo -e "${LMAGENTA}----------------------------------------"
                xbps-install $REPLY -y
                ln -s /etc/sv/$REPLY /etc/runit/runsvdir/default/
                echo -e "----------------------------------------${NORMAL}"
            fi
        else
            echo -e "${LBLUE}I'll install LXDM${NORMAL}"
            echo -e "${LMAGENTA}----------------------------------------"
            xbps-install lxdm -y
            ln -s /etc/sv/lxdm /etc/runit/runsvdir/default/
            echo -e "----------------------------------------${NORMAL}"

        fi

        echo -e "${LBLUE}Now I'll install LXDE(pkg)"
        echo -e "${LMAGENTA}----------------------------------------"
        xbps-install lxde -y
        echo -e "----------------------------------------${NORMAL}"
    #========================================================

    #LXQT
    #========================================================
    elif [[ $REPLY = "lxqt" ]]; then
        echo -e "\n${LBLUE}So, now I'll install LXQT :3${NORMAL}\n"

        echo -e "${YELLOW}Do you want to install lxdm? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
        read

        if [[ $REPLY = "no" || $REPLY = "n" || $REPLY = "N" || $REPLY = "No" ]]; then
            echo -e "${LYELLOW}If you want to install any DM, you can enter the exact package name (or enter 'NO' for skip)"
            echo -e "You can find your DM by 'xbps-query -Rs <pkg name>' ;)${NORMAL}"
            read

            if [[ $REPLY != "NO" ]]; then
                echo -e "${LBLUE}So, I'll install ${REPLY} ${NORMAL}"
                echo -e "${LMAGENTA}----------------------------------------"
                xbps-install $REPLY -y
                ln -s /etc/sv/$REPLY /etc/runit/runsvdir/default/
                echo -e "----------------------------------------${NORMAL}"
            fi
        else
            echo -e "${LBLUE}I'll install LXDM${NORMAL}"
            echo -e "${LMAGENTA}----------------------------------------"
            xbps-install lxdm -y
            ln -s /etc/sv/lxdm /etc/runit/runsvdir/default/
            echo -e "----------------------------------------${NORMAL}"

        fi

        echo -e "${LBLUE}Now I'll install LXQT(pkg)"
        echo -e "${LMAGENTA}----------------------------------------"
        xbps-install lxqt xorg-minimal xdg-user-dirs xdg-desktop-portal-lxqt xorg xorg-fonts nm-tray -y
        echo -e "----------------------------------------${NORMAL}"
    #========================================================

    #OPENBOX
    #========================================================
    elif [[ $REPLY = "openbox" ]]; then
        echo -e "\n${LBLUE}So, now I'll install OPENBOX :3${NORMAL}\n"

        echo -e "${LBLUE}Now I'll install OPENBOX(pkg)"
        echo -e "${LMAGENTA}----------------------------------------"
        xbps-install openbox xorg-minimal xdg-user-dirs xdg-desktop-portal-gtk xdg-utils xorg xorg-fonts xfce4-terminal obconf obmenu-generator pcmanfm nitrogen tint2 -y
        echo -e "----------------------------------------${NORMAL}"

        echo -e "${YELLOW}Do you want to install lxdm? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
        read

        if [[ $REPLY = "no" || $REPLY = "n" || $REPLY = "N" || $REPLY = "No" ]]; then
            echo -e "${LYELLOW}If you want to install any DM, you can enter the exact package name (or enter 'NO' for skip)"
            echo -e "You can find your DM by 'xbps-query -Rs <pkg name>' ;)${NORMAL}"
            read

            if [[ $REPLY != "NO" ]]; then
                echo -e "${LBLUE}So, I'll install ${REPLY} ${NORMAL}"
                echo -e "${LMAGENTA}----------------------------------------"
                xbps-install $REPLY -y
                ln -s /etc/sv/$REPLY /etc/runit/runsvdir/default/
                echo -e "----------------------------------------${NORMAL}"
            fi
        else
            echo -e "${LBLUE}I'll install LXDM${NORMAL}"
            echo -e "${LMAGENTA}----------------------------------------"
            xbps-install lxdm -y
            ln -s /etc/sv/lxdm /etc/runit/runsvdir/default/
            echo -e "----------------------------------------${NORMAL}"

        fi

        echo -e "${LBLUE}Please run ./wm/openbox/theme.sh"
    #========================================================
    else
        echo -e "${RED} I don't know what is it :( and Skip"
    fi
fi
#========================================================

# NVIDIA
#========================================================
echo -e "${YELLOW}Do you have NVIDIA GPU? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
read

if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
    echo -e "${LBLUE}Now I'll install NVIDIA driver for you${NORMAL}"
    echo -e "${LMAGENTA}----------------------------------------"
    xbps-install nvidia -y
    echo -e "----------------------------------------${NORMAL}"
else
    echo -e "${LBLUE}No NVIDIA stuff installed ${NORMAL}"
fi
#========================================================

#Pipewire
#========================================================
echo -e "${YELLOW}Do you want to install pipewire? 'No/n/N/no' if u want pulseaudio ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
read

if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
    echo -e "${LBLUE}Now I'll install pipewire for you${NORMAL}"
    echo -e "${LMAGENTA}----------------------------------------"
    xbps-install -y alsa-utils alsa-firmware alsa-pipewire apulse bluez-alsa \
                    ffmpeg alsa-plugins-ffmpeg \
                    pipewire wireplumber \
                    pavucontrol
    ln -s /usr/share/applications/pipewire.desktop /etc/xdg/autostart/pipewire.desktop
    ln -s /usr/share/applications/wireplumber.desktop /etc/xdg/autostart/wireplumber.desktop
    ln -s /usr/share/applications/pipewire-pulse.desktop /etc/xdg/autostart/pipewire-pulse.desktop
    mkdir -p /etc/alsa/conf.d
    ln -s /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d
    ln -s /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d
    ln -s /etc/sv/alsa /var/service
    echo -e "----------------------------------------${NORMAL}"
else
    echo -e "${LBLUE}Now I'll install pulseaudio for you${NORMAL}"
    echo -e "${LMAGENTA}----------------------------------------"
    xbps-install pulseaudio alsa-plugins-pulseaudio -y
fi
#========================================================

# VM
#========================================================
echo -e "${YELLOW}Do you install void on VM? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
read

if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
    
    echo -e "${YELLOW}VirtualBox? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
    read

    if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
        echo -e "${LBLUE}Now I'll install VBOX Deps for you${NORMAL}"
        echo -e "${LMAGENTA}----------------------------------------"
        xbps-install linux-headers virtualbox-ose-guest xf86-video-vmware -y
        ln -s /etc/sv/vboxservice /var/service
        echo -e "----------------------------------------${NORMAL}"
    else
        echo -e "${LBLUE}Now I'll install QEMU/LIBVIRT Deps for you${NORMAL}"
        echo -e "${LMAGENTA}----------------------------------------"
        xbps-install qemu-ga -y
        ln -s /etc/sv/vboxservice /var/service
        echo -e "----------------------------------------${NORMAL}"
    fi
else
    echo -e "${LBLUE}No VM stuff installed ${NORMAL}"
fi
#========================================================

# LAPTOP
#========================================================
echo -e "${YELLOW}Do you install void on LAPTOP? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
read

if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
    echo -e "${LBLUE}Now I'll install LAPTOP Deps for you${NORMAL}"
    echo -e "${LMAGENTA}----------------------------------------"
    xbps-install cronie chrony tlp tlp-rdw powertop -y
    ln -s /etc/sv/cronie /var/service
    ln -s /etc/sv/chronyd /var/service
    ln -s /etc/sv/tlp /var/service
    echo -e "----------------------------------------${NORMAL}"
else
    echo -e "${LBLUE}No LAPTOP stuff installed ${NORMAL}"
fi
#========================================================

#APPS
#========================================================
echo -e "${YELLOW}Do you want to install essential apps (RECOMMENDED) (like browser/media player/firewall/flatpak)? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
read

if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
    echo -e "${LMAGENTA}----------------------------------------"
    xbps-install void-repo-nonfree void-repo-multilib-nonfree -y
    xbps-install -Syu
    xbps-install -y firefox \
                    vlc \
                    mpv \
                    nano \
                    noto-fonts-ttf noto-fonts-ttf-extra noto-fonts-cjk \
                    font-firacode font-fira-ttf \
                    font-awesome \
                    dejavu-fonts-ttf \
                    ttf-ubuntu-font-family \
                    flatpak \
                    ufw gufw ufw-extras \
                    zip xz unzip unrar p7zip binutils
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    echo -e "----------------------------------------${NORMAL}"

    echo -e "${YELLOW}Do you want to put ufw(firewall) in autorun? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
    read

    if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
        echo -e "${LMAGENTA}----------------------------------------"
        ln -s /etc/sv/ufw /var/service/
        echo -e "----------------------------------------${NORMAL}"
    fi
fi
#========================================================

# Printer Support
#========================================================
echo -e "${YELLOW}Do you want printer support? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
read

if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
    echo -e "${LBLUE}Now I'll install Printer Deps for you${NORMAL}"
    echo -e "${LMAGENTA}----------------------------------------"
    xbps-install cups cups-pk-helper cups-filters \
                    foomatic-db foomatic-db-nonfree foomatic-db-engine \
                    gutenprint hplip \
                    epson-inkjet-printer-escpr \
                    cnijfilter2 -y
    ln -s /etc/sv/cupsd /var/service

    echo -e "----------------------------------------${NORMAL}"
else
    echo -e "${LBLUE}No Printer stuff installed ${NORMAL}"
fi
#========================================================

#NetworkManager
#========================================================
echo -e "${YELLOW}Do you want to install NetworkManager? (RECOMENDED IF USING DE) ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
read

if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
    echo -e "${LMAGENTA}----------------------------------------"
    rm -rf /etc/runit/runsvdir/default/dhcpcd
    rm -rf /etc/runit/runsvdir/default/wpa_supplicant
    xbps-install NetworkManager -y
    ln -s /etc/sv/NetworkManager /etc/runit/runsvdir/default/
    echo -e "----------------------------------------${NORMAL}"
fi
#========================================================

#My "service" script install
#========================================================
echo -e "${YELLOW}Do you want to install my 'service' script? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
read

if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
    echo -e "${LBLUE}This script will help you in the future${NORMAL}"
    echo -e "${LMAGENTA}----------------------------------------"
    echo "Installation"
    cp -v /${PWD}/service /usr/bin
    echo -e "----------------------------------------${NORMAL}"
else
    echo -e "${LBLUE}So sad${NORMAL}"
fi
#========================================================

#Delete Installation script
#========================================================
echo -e "${YELLOW}Do you want to delete Installation script? ${NORMAL}[${GREEN}Y${NORMAL}/${RED}n${NORMAL}]"
read

if [[ $REPLY = "yes" || $REPLY = "y" || $REPLY = "Y" || $REPLY = "Yes" || $REPLY = " " || $REPLY = "" ]]; then
    echo -e "${LBLUE}Auto-delete Installation script :)${NORMAL}"
    echo -e "${LMAGENTA}----------------------------------------"
    rm -rv /${PWD}
    echo -e "----------------------------------------${NORMAL}"
#========================================================
else
    #The end
    echo -e "${LYELLOW}Thank you for using my installation script :3${NORMAL}"
fi
