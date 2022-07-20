
git clone "https://aur.archlinux.org/yay.git"
cd ./yay

makepkg -si

#cd ..
#cd ./ldbus
#makepkg -si

#cd ..
#cd ./luarocks
#tar zxpf luarocks.tar.gz
#cd ./luarocks-3.9.0
#./configure --lua-version=5.3 --versioned-rocks-dir
#make
#sudo make install
#cd ..

#sudo luarocks install lgi
#sudo luarocks install dbus_proxy

#python -m pip install PyGObject

cd ./..
./yay-installs.sh

# vim coc-rust-analyzer plugin
vim --cmd "" -c ":CocInstall coc-rust-analyzer" -c ":qa!"

# awesomewm cpu-widget
curl -sL https://raw.githubusercontent.com/streetturtle/awesome-wm-widgets/master/cpu-widget/cpu-widget.lua >> ~/.config/awesome/cpu-widget.lua
# awesomewm ram widget
curl -sL https://raw.githubusercontent.com/streetturtle/awesome-wm-widgets/master/ram-widget/ram-widget.lua >> ~/.config/awesome/ram-widget.lua
# awesomewm battery widget
    #icon
curl -sL https://github.com/streetturtle/awesome-wm-widgets/blob/master/batteryarc-widget/spaceman.jpg?raw=true >> ~/.config/awesome/awesome-wm-widgets/spaceman.jpg
    #script
curl -sL https://raw.githubusercontent.com/streetturtle/awesome-wm-widgets/master/batteryarc-widget/batteryarc.lua >> ~/.config/awesome/batteryarc.lua
# awesomewm calander widget
curl -sL https://raw.githubusercontent.com/streetturtle/awesome-wm-widgets/master/calendar-widget/calendar.lua >> ~/.config/awesome/calendar.lua

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# github.com/jceb/dex
# Use for autostarting .desktop files
systemctl --user add-wants autostart.target polkit-dumb-agent.service

echo "Please run vim to ensure plugins install correctly, then run ':CocInstall coc-rust-analyzer' to ensure rust is ready to go"
