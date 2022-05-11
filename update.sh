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

    if [ -e $dest ]
    then
        echo "file exists, updating"
    else
        mkdir -p $dest
    fi

    sudo /bin/cp -RT $src $dest
}

copy_shell_configs(){
    # powerlevel
    $(copy_helper $src/home/.p10k.zsh $HOME/.p10k.zsh)
    # urxvt
    $(copy_helper $src/home/.Xresources $HOME/.Xresources)
    # zshell
    $(copy_helper $src/home/.zshrc $HOME/.zshrc)
}

read -p "WARNING: This WILL override ALL existing settings. Are you sure? (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Aborting"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

while [ $# -gt 0 ] ; do
  case $1 in
    -a | --awesome)  $(copy_helper $src/home/.config/awesome $HOME/.config/awesome);;
    -s | --shell)    $(copy_shell_configs);;
    -r | --ranger)   $(copy_helper $src/home/.config/ranger $HOME/.config/ranger) ;;
    -n | --neofetch) $(copy_helper $src/home/.config/neofetch $HOME/.config/neoftech) ;;
    -p | --picom)    $(copy_helper $src/home/.config/picom.conf $HOME/.config/picom.conf) ;;
    --rofi)          $(copy_helper $src/home/.config/rofi $HOME/.config/rofi) ;;
    --sys)           $(copy_helper $src/home/.config/systemd $HOME/.config/systemd) ;;
    --all)           $(copy_helper $src/home $HOME) & $(copy_helper $src/etc /etc) ;;

    -h | --help) 
        echo "\
A simple inbetween script for updating config files
several flags can be passed, but for now, they must be individual flags (e.g. -a -s vs -sa) (TODO: fix this)
-a, --awesome : awesome wm configs
-s, --shell   : zsh, powerline, and .Xresources
-r, --ranger  : ranger configs
-n, --neofetch: neofetch configs
-p, --picom   : picom configuration file
--rofi        : rofi configuration file
--sys         : systemd user settings
--all         : updates all config files, even ones that don't have a dedicted flag above
-h, --help    : Shows this menu
"
  esac
  shift
done
echo "Task didn't error, maybe"