
git clone "https://aur.archlinux.org/yay.git"
cd ./yay

makepkg -si

cd ..
cd ./ldbus
makepkg -si

cd ..
cd ./luarocks
tar zxpf luarocks.tar.gz
cd ./luarocks-3.9.0
./configure --lua-version=5.3
make
sudo make install
cd ..
sudo luarocks install --server=https://luarocks.org/dev lua-dbus DBUS_INCDIR=/usr/include/dbus-1.0/ DBUS_ARCH_INCDIR=/usr/lib/dbus-1.0/include
sudo mv /usr/local/share/lua/5.3/lua-dbus/init.lua /usr/local/share/lua/5.3/lua-dbus/lua-dbus.lua
# This one could be broken
sudo mv /usr/local/share/lua/5.3/lua-dbus/awesome/init.lua /usr/local/share/lua/5.3/lua-dbus/awesome/lua-dbus.lua


cd ./..
./yay-installs.sh


# github.com/jceb/dex
# Use for autostarting .desktop files
systemctl --user add-wants autostart.target polkit-dumb-agent.service