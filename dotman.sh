#!/bin/bash

dotfile_dir=$(cd $(dirname $0) && pwd)

declare -A targets=(
    ["alacritty"]=".config/"
    [".bash_profile"]=""
    ["i3"]=".config/"
    ["nvim"]=".config/"
    ["picom"]=".config/"
    ["polybar"]=".config/"
    [".xinitrc"]=""
)

action=$1
if [[ "$action" != "install" && "$action" != "uninstall" ]]; then
    echo "usage: $0 [install|uninstall]"
    exit 1
fi

install() {
    local src=$1
    local dst=$2
    if [[ ! -e "$dst" ]]; then
        ln -s $1 $2
    fi
}

uninstall() {
    local src=$1
    local dst=$2
    local ptr=$(readlink -f $dst)
    if [[ "$ptr" == "$src" ]]; then
        unlink $dst
    fi
}

for package in "${!targets[@]}"; do
    target="${targets[$package]}"
    src="${dotfile_dir}/${package}"
    dst="${HOME}/${target}${package}"
    echo "${action}ing package $package at $dst"
    "$action" "$src" "$dst"
done

