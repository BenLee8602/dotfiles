#!/bin/bash

dotfile_dir=$(cd $(dirname $0) && pwd)

declare -A targets=(
    [alacritty]="$HOME/.config/alacritty"
    [i3]="$HOME/.config/i3"
    [nvim]="$HOME/.config/nvim"
    [picom]="$HOME/.config/picom"
    [polybar]="$HOME/.config/polybar"
)

action=$1

if [ "$action" = "install" ]; then
    for package in "${!targets[@]}"; do
        target="${targets[$package]}"
        mkdir -p $target
        stow -d $dotfile_dir -t $target $package
        echo "installed package $package to $target"
    done

elif [ "$action" = "uninstall" ]; then
    for package in "${!targets[@]}"; do
        target="${targets[$package]}"
        stow -D -d $dotfile_dir -t $target $package
        rmdir $target --ignore-fail-on-non-empty
        echo "uninstalled package $package from $target"
    done

else
    echo "usage: $0 {install|uninstall}"
fi

