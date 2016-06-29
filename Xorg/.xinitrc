# vim: set filetype=sh :
WM=i3
XRESOURCES=$HOME/.Xresources
XMODMAP=$HOME/.Xmodmap



[ -f $XRESOURCES ] && xrdb $XRESOURCES

# source scripts in /etc/X11/xinit/xinitrc.d/
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

$HOME/scripts/wallpaper.sh &
xss-lock -- $HOME/bin/lock_desktop.sh &

exec $WM
