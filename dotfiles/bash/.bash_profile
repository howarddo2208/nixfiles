# this works for login shell
# for interactive shell, copy this and paste to /etc/bash.bashrc
BDOTDIR="$HOME/.config/bash"

if [ -f "$BDOTDIR/bashrc" ]; then
    . "$BDOTDIR/bashrc"
fi
