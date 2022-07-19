#!/bin/bash
if [ $(whoami) == "root" ]; then
    echo "Please only run this script as user, because it contains user specific paths, and it will ask for sudo"
    exit
fi


cur_usr="$(whoami)"
cur_dir=`dirname $(realpath $0)`
src=$cur_dir/src

copy_helper(){
    src="$1"
    dest="$2"
    do_su="$3"

    #if [ ! -e "$dest" ]
    #then
    #    mkdir -p "$dest"
    #fi

    case $3 in
        y|ye|yes) sudo /bin/cp -RT "$src" "$dest" && sudo chown $cur_usr "$dest" ;;
        *) /bin/cp -RT "$src" "$dest" ;;
    esac

}

copy_shell_configs(){
    src=$1
    HOME=$2

    # powerlevel
    sudo /bin/cp -RT $src/home/.p10k.zsh $HOME/.p10k.zsh
    # urxvt
    sudo /bin/cp -RT $src/home/.Xresources $HOME/.Xresources
    # zshell
    sudo /bin/cp -RT $src/home/.zshrc $HOME/.zshrc
}

copy_custom_commands() {
    src=$1
    
    # custom sleep command
    sudo /bin/cp -RT $src/usr/bin/sleep /usr/bin/sleep
    sudo chown $cur_usr /usr/bin/sleep
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
    -a | --awesome)  $(copy_helper $src/home/.config/awesome $HOME/.config/awesome n) ;; 
    -d | --dbus)     $(copy_helper $src/home/.local/share/ $HOME/.local/share n) ;;
    # -s | --shell)    $(copy_shell_configs $src $HOME n) ;;
    -s | --scripts)  $(copy_custom_commands $src) ;;
    -r | --ranger)   $(copy_helper $src/home/.config/ranger $HOME/.config/ranger n) ;;
    -n | --neofetch) $(copy_helper $src/home/.config/neofetch $HOME/.config/neofetch n) ;;
    -p | --polybar)  $(copy_helper $src/home/.config/polybar $HOME/.config/polybar n) ;;
    --picom)    $(copy_helper $src/home/.config/picom.conf $HOME/.config/picom.conf n) ;;
    --rofi)          $(copy_helper $src/home/.config/rofi $HOME/.config/rofi n) ;;
    --vcode)         $(copy_helper "$src/home/.config/VSCodium" "$HOME/.config/VSCodium" n) ;;
    -v | --vim)      $(copy_helper $src/home/.vimrc $HOME/.vimrc n);;
    --sys)           $(copy_helper $src/home/.config/systemd $HOME/.config/systemd n) ;;
    --all)           $(copy_helper $src/home $HOME) & $(copy_helper $src/etc /etc y) ;;

    -h | --help) 
        echo "\
A simple inbetween script for updating config files
several flags can be passed, but for now, they must be individual flags (e.g. -a -s vs -sa) (TODO: fix this)
-a, --awesome : awesome wm configs
-s, --shell   : zsh, powerline, and .Xresources NOTE: DISABLED
-r, --ranger  : ranger configs
-n, --neofetch: neofetch configs
-p, --polybar : polybar configuration files
-v, --vim     : vim rc file
--picom       : picom configuration file
--rofi        : rofi configuration file
--vcode       : Visual Studio Code user settings
--sys         : systemd user settings
--all         : updates all config files, even ones that don't have a dedicted flag above
-h, --help    : Shows this menu
"
  esac
  shift
done
echo "Task didn't error, maybe"
