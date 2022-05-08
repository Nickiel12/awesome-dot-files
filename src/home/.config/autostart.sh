xbindkeys
picom -b
systemctl --user start autostart.target
xautolock -time 10 -locker /usr/bin/i3lock-fancy -detectsleep