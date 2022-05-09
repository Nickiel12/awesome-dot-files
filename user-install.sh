
cd ~/dot-files/yay

makepkg -si

~/dot-files/yay_installs.sh


# github.com/jceb/dex
# Use for autostarting .desktop files
systemctl --user add-wants autostart.target polkit-dumb-agent.service