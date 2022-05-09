#!/bin/bash

if [ $(whoami) == "root" ]; then
    echo "Please only run this script as user, because it contains user specific paths, and it will ask for sudo"
    exit
fi

cur_dir=`dirname $(realpath $0)`
src=$cur_dir/src

copy_helper(){
    src=$1
    dest=$2
    result=sudo /bin/cp -RT $src $dest
}

copy_shell_configs(){
    # powerlevel
    $(copy_helper $src/.p10k.zsh $HOME/.p10k.zsh)
    # urxvt
    $(copy_helper $src/.Xresources $HOME/.Xresources)
    # zshell
    $(copy_helper $src/.zshrc $HOME/.zshrc)
}

echo "WARNING: This WILL override ALL existing settings. Are you sure? (y/n)"
read response

if ($respone -ne "y") then
    echo "Aborting"
    exit
fi

while [ $# -gt 0 ] ; do
  case $1 in
    -a | --awesome) sudo $cur_dir/scripts/update_awesome_configs.sh $HOME;;
    -s | --shell)    $(copy_shell_configs);;
    -r | --ranger)   $(copy_helper $src/home/.config/ranger $HOME/.config/ranger) ;;
    -n | --neofetch) $(copy_helper $src/home/.config/neofetch $HOME/.config/neoftech) ;;
    -p | --picom     $(copy_helper $src/home/.config/picom.conf $HOME/.config/picom.conf) ;;
    --sys)           $(copy_helper $src/home/.config/systemd $HOME/.config/systemd) ;;
    --all)          sudo $cur_dir/scripts/update_all.sh $HOME ;;

    -h | --help) 
        echo "\
A simple inbetween script for updating config files
several flags can be passed, but for now, they must be individual flags (e.g. -a -s vs -sa) (TODO: fix this)
-a, --awesome : awesome wm configs
-s, --shell   : zsh, powerline, and .Xresources
-r, --ranger  : ranger configs
-n, --neofetch: neofetch configs
-p, --picom   : picom configuration file
--sys         : systemd user settings
--all         : updates all config files, even ones that don't have a dedicted flag above
"
  esac
  shift
done