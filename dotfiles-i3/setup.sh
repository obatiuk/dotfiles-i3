#!/usr/bin/env bash

. ../functions

#
# Variables
#

dotfiles_dir=$(pwd)

#
# Setup
#

if ask "Do you want to install i3 configuration?"; then

    ask "Install required dependencies? (Distro: ${distro})?" Y && bash ./dependencies-${distro}.sh

    # Target folders

    [ -d ${target_dir}/.config ] || mkdir -p ${target_dir}/.config

    # i3 Configuration

    ln -sfn ${dotfiles_dir}/.i3 ${target_dir}/.i3
    ln -sfn ${dotfiles_dir}/.config/i3status.conf ${target_dir}/.config/i3status.conf

    # Wallpaper

    ln -sfn ${dotfiles_dir}/.config/wallpaper ${target_dir}/.config/wallpaper

    # Power management

    if ask "Apply default power-management configuration?"; then
        ## Enabling Xfce4 power manager icon
        xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/show-tray-icon -n -t int -s 1
        ## Lid action configuration
        xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/logind-handle-lid-switch -n -t bool -s false
        xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/lid-action-on-battery -n -t uint -s 1
        xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/lid-action-on-ac -n -t uint -s 1
    fi

    # X settings

    ln -sfn ${dotfiles_dir}/.profile-i3 ${target_dir}/.profile-i3

    echo "i3 configuration files were successfully installed"
else
    echo "i3 configuration files were not installed".
fi
