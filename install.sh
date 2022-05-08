
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

echo "Now switch to $USER and run user-install.sh"