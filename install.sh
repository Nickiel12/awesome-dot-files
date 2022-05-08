
echo "Enter valid user home directory for config files: "
read USER

cur_dir=`dirname $(realpath $0)`

pacman_file="/pacman.txt"

pacman -S --noconfirm --overwrite="*" archlinux-keyring base-devel
pacman -S --noconfirm $(cat $cur_dir$pacman_file | cut -d' ' -f1)

yay_file="/yay_installs.sh"

# Recreate and copy config files
# the \cp overwrite the alias to cp=cp -i, so there will be no confirmation
\cp -R $cur_dir"/src/etc" "/"
\cp -R $cur_dir"/src/home" "/home/"$USER

# https://tecadmin.net/adding-line-in-middle-of-file-using-command-in-linux/
# -i "##i..." the -i says insert, and the ## before i says what line
sed -i "80inick ALL=(ALL) ALL" /etc/sedoers
sed -i "19izstyle :compinstall filename '/home/$USER/.zshrc'" /home/$USER/.zshrc

# for the "light" command
usermod -G video $USER

systemctl enable NetworkManager
# github.com/jceb/dex
# Use for autostarting .desktop files
systemctl --user add-wants autostart.target polkit-dumb-agent.service
systemctl enable lightdm
