
cur_dir=`dirname $(realpath $0)`
home_dir=$1
# powerlevel
/bin/cp $cur_dir/../src/.p10k.zsh $home_dir/.p10k.zsh
# urxvt
/bin/cp $cur_dir/../src/.Xresources $home_dir/.Xresources
# zshell
/bin/cp $cur_dir/../src/.zshrc $home_dir/.zshrc