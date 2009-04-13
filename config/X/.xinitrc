#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#

# exec gnome-session
# exec startkde
# exec startxfce4
# exec icewm
# exec openbox
# exec blackbox
# exec fluxbox
# exec ratpoison
# exec dwm
# ... or any other WM of your choosing ...

#feh --bg-scale .bg/01_elvinntooka_epreuve_1280_1024.png
#feh --bg-scale .bg/deviant/Blue_Eye_wallpaper_by_NimKorko.png
#feh --bg-scale .bg/deviant/6_1680.jpg

keychain ~/.ssh/id_rsa
. ~/.keychain/$HOSTNAME-sh

#gnome-screensaver
#xscreensaver -nosplash &
#basket &
#stalonetray -t -geometry +14100+855 --grow-gravity E &
#amazing&
xrandr --output VGA1 --auto --left-of LVDS
exec awesome
