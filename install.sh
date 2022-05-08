
echo "Enter valid user for config files: "
read USER

cur_dir=`dirname $(realpath $0)`

# Update system
pacman -Syu --noconfirm
# some packages wouldn't install without updating the keyring
pacman -S --noconfirm --overwrite="*" archlinux-keyring
# remove existing vim for gvim
pacman -R --noconfirm vim
# install packages from file
pacman -S --noconfirm $(cat $cur_dir"/pacman.txt" | cut -d' ' -f1)


#cd /home/$USER
#git clone https://github.com/Nickiel12/awesome-dot-files
#chmod +x /home/$USER/awesome-dot-files/user-install.sh

# install yay
pacman -S --noconfirm --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay
sudo -u $USER makepkg -si

chown nicholas $cur_dir"/yay_installs.sh"
chmod +x $cur_dir/yay_installs.sh
sudo -u $USER $cur_dir"/yay_installs.sh"
chown root $cur_dir"/yay_installs.sh"

chmod +x $cur_dir"/src/home/.config/ranger/scope.sh"
chmod +x $cur_dir"/src/home/.config/autostart.sh"

# Recreate and copy config files
# the \cp overwrite the alias to cp=cp -i, so there will be no confirmation
# the -T flag does not create a source dir in the target folder
# the -R flag for recursive
/bin/cp -RT $cur_dir"/src/etc" "/"
/bin/cp -RT $cur_dir"/src/home" "/home/"$USER

# https://tecadmin.net/adding-line-in-middle-of-file-using-command-in-linux/
# -i "##i..." the -i says insert, and the ## before i says what line
sed -i "19izstyle :compinstall filename '/home/$USER/.zshrc'" /home/$USER/.zshrc
sed -i "80i$USER ALL=(ALL) ALL" /etc/sudoers

# for the "light" command
usermod -G video $USER
# change default shell for user
usermod -s /usr/bin/zsh $USER

systemctl enable NetworkManager
# github.com/jceb/dex
# Use for autostarting .desktop files
systemctl --user add-wants autostart.target polkit-dumb-agent.service
# lightdm will start xorg, and xinit will start awesome
systemctl enable lightdm