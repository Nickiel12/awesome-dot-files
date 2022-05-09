
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

# install yay
pacman -S --noconfirm --needed git base-devel
cd /home/$USER/dot-files
git clone https://aur.archlinux.org/yay.git
cd $cur_dir

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
# lightdm will start xorg, and xinit will start awesome
systemctl enable lightdm

/bin/cp $cur_dir/user-install.sh /home/$USER/user-install.sh
chmod +x /home/$USER/user-install.sh
/bin/cp $cur_dir/yay_installs.sh /home/$USER/dot-files/yay_installs.sh
chmod +x /home/$USER/dot-files/yay_installs.sh