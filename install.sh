#!/bin/bash

echo "Enter valid user for config files: "
read USER

if [ `sed -n "/^$USER/p" /etc/passwd` ]
then
    echo "User [$USER] exists"
else
    echo "User [$USER] doesn't exist"
    
    read -p "Create new user? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        useradd -m -G video $USER
        echo "Created user, continuing"
    else
        echo "Aborting"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
    fi

fi

cur_dir=`dirname $(realpath $0)`

# Update system
pacman -Syu --noconfirm
# some packages wouldn't install without updating the keyring
pacman -S --noconfirm --overwrite="*" archlinux-keyring
# remove existing vim for gvim
pacman -R --noconfirm vim
# install packages from file
pacman -S --noconfirm $(cat $cur_dir"/pacman.txt" | cut -d' ' -f1)
pacman -S --noconfirm sudo

# install yay deps
pacman -S --noconfirm --needed git base-devel

# make required scripts executable
chmod +x $cur_dir"/src/home/.config/ranger/scope.sh"
sudo -u $USER chmod +x $cur_dir"/src/home/.config/autostart.sh"

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

cd "/home/"$USER
git clone "https://github.com/Nickiel12/awesome-dot-files"
cd ./awesome-dot-files

curl -sL install-node.vercel.app/lts | bash

chown -R $USER "/home"/$USER
chmod +x ./user-install.sh
chmod +x ./yay-installs.sh
