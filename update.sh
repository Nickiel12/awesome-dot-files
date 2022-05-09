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

  esac
  shift
done
echo $U, $A $B