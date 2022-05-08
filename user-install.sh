#from yay src github
pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

$cur_dir"/yay_installs.sh"

# https://tecadmin.net/adding-line-in-middle-of-file-using-command-in-linux/
# -i "##i..." the -i says insert, and the ## before i says what line
sed -i "19izstyle :compinstall filename '/home/$USER/.zshrc'" /home/$USER/.zshrc

# Recreate and copy config files
# the \cp overwrite the alias to cp=cp -i, so there will be no confirmation
sudo /bin/cp -R $cur_dir"/src/etc" "/"
sudo /bin/cp -R $cur_dir"/src/home" "/home/"$USER

sudo systemctl enable NetworkManager
# github.com/jceb/dex
# Use for autostarting .desktop files
sudo systemctl --user add-wants autostart.target polkit-dumb-agent.service
# lightdm will start xorg, and xinit will start awesome
sudo systemctl enable lightdm