
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
./configure --lua-version=5.3 --versioned-rocks-dir
make
sudo make install
cd ..

sudo luarocks install lgi
sudo luarocks install dbus_proxy

python -m pip install PyGObject

cd ./..
./yay-installs.sh


# github.com/jceb/dex
# Use for autostarting .desktop files
systemctl --user add-wants autostart.target polkit-dumb-agent.service