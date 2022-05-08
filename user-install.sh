
echo "Enter valid user for config files: "
read USER

cur_dir=`dirname $(realpath $0)`

#from yay src github
sudo pacman -S --noconfirm --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

$cur_dir"/yay_installs.sh"

sudo chmod +x $cur_dir"/src/home/.config/ranger/scope.sh"
sudo chmod +x $cur_dir"/src/home/.config/autostart.sh"
sudo chmod +x $cur_dir"/src/home/.config/.sh"

# Recreate and copy config files
# the \cp overwrite the alias to cp=cp -i, so there will be no confirmation
# the -T flag does not create a source dir in the target folder
sudo /bin/cp -RT $cur_dir"/src/etc" "/"
sudo /bin/cp -RT $cur_dir"/src/home" "/home/"$USER

# https://tecadmin.net/adding-line-in-middle-of-file-using-command-in-linux/
# -i "##i..." the -i says insert, and the ## before i says what line
sed -i "19izstyle :compinstall filename '/home/$USER/.zshrc'" /home/$USER/.zshrc

sudo usermod -s /usr/bin/zsh $USER

sudo systemctl enable NetworkManager
# github.com/jceb/dex
# Use for autostarting .desktop files
sudo systemctl --user add-wants autostart.target polkit-dumb-agent.service
# lightdm will start xorg, and xinit will start awesome
sudo systemctl enable lightdm