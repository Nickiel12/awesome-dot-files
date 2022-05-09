#!/bin/bash

if [ $(whoami) == "root" ]; then
    echo "Please only run this script as user, because it contains user specific paths, and it will ask for sudo"
    exit
fi


cur_dir=`dirname $(realpath $0)`
while [ $# -gt 0 ] ; do
  case $1 in
    -a | --awesome) sudo $cur_dir/scripts/update_awesome_configs.sh $HOME;;
    -s | --shell)   sudo $cur_dir/scripts/update_shell_configs.sh $HOME;;
    -r | --ranger)  sudo $cur_dir/scripts/update_ranger_configs.sh $HOME ;;
    --all)          sudo $cur_dir/scripts/update_all.sh $HOME ;;

    -h | --help) 
        echo "\
A simple inbetween script for updating config files
-a, --awesome : awesome wm configs
-s, --shell   : zsh, powerline, and .Xresources
-r, --ranger  : ranger configs
--all         : updates all config files, even ones that don't have a dedicted flag above
"
  esac
  shift
done
echo $U, $A $B