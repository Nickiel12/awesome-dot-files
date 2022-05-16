
git clone "https://aur.archlinux.org/yay.git"
cd ./yay

makepkg -si

cd ..
cd ./lua-ldbus

makepkg -si

cd ./..
./yay-installs.sh


# github.com/jceb/dex
# Use for autostarting .desktop files
systemctl --user add-wants autostart.target polkit-dumb-agent.service