
cur_dir=`dirname $(realpath $0)`

pacman_file="/pacman.txt"

pacman -S --overwrite="*" archlinux-keyring base-devel
pacman -S $(cat yourfilename | cut -d' ' -f1)
pacman -S $cur_dir$pacman_file

yay_file="/yay_installs.sh"


mv $cur_dir"/src/lightdm_conf.txt" "/etc/lightdm/lightdm.conf"

systemctl enable NetworkManager
systemctl enable polkit
systemctl enable lightdm
