
echo "Enter valid user for config files: "
read USER

cur_dir=`dirname $(realpath $0)`

pacman -Syu --noconfirm
pacman -S --noconfirm --overwrite="*" archlinux-keyring
pacman -S --noconfirm base-devel
pacman -R --noconfirm vim
pacman -S --noconfirm $(cat $cur_dir"/pacman.txt" | cut -d' ' -f1)

sed -i "80i$USER ALL=(ALL) ALL" /etc/sudoers
# for the "light" command
usermod -G video $USER

cd /home/$USER
git clone https://github.com/Nickiel12/awesome-dot-files
chmod +x /home/$USER/awesome-dot-files/user-install.sh
chmod +x /home/$USER/awesome-dot-files/yay_installs.sh

pacman -S --noconfirm --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay
sudo -u nicholas makepkg -si

sudo -u nicholas$cur_dir"/yay_installs.sh"

chmod +x $cur_dir"/src/home/.config/ranger/scope.sh"
chmod +x $cur_dir"/src/home/.config/autostart.sh"
chmod +x $cur_dir"/src/home/.config/.sh"

# Recreate and copy config files
# the \cp overwrite the alias to cp=cp -i, so there will be no confirmation
# the -T flag does not create a source dir in the target folder
/bin/cp -RT $cur_dir"/src/etc" "/"
/bin/cp -RT $cur_dir"/src/home" "/home/"$USER

# https://tecadmin.net/adding-line-in-middle-of-file-using-command-in-linux/
# -i "##i..." the -i says insert, and the ## before i says what line
sed -i "19izstyle :compinstall filename '/home/$USER/.zshrc'" /home/$USER/.zshrc

usermod -s /usr/bin/zsh $USER

systemctl enable NetworkManager
# github.com/jceb/dex
# Use for autostarting .desktop files
systemctl --user add-wants autostart.target polkit-dumb-agent.service
# lightdm will start xorg, and xinit will start awesome
systemctl enable lightdm