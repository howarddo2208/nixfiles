#!/bin/sh
alias reloadshell='source $ZSHRC'
alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

# neovim
alias v='nvim'
alias vv='nvim .'
alias zshrc="nvim $ZDOTDIR"
alias nvimrc='nvim ~/.config/nvim/'

# tmux
# alias txi='tmuxifier' # tmux session preset
alias tmuxrc='nvim ~/.tmux.conf'


# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# easier to read disk
alias df='df -h'     # human-readable sizes

# git
alias m="git checkout master"
alias s="git checkout stable"
alias g='lazygit'

# other
alias cs="cht.sh" # cheatsheet for command lines

#nix related
alias hms="home-manager switch -f ~/nixfiles/home.nix"
alias ckshell='if [ -n "$IN_NIX_SHELL" ]; then echo "Inside nix-shell"; else echo "Not inside nix-shell"; fi;'

case "$(uname -s)" in

Darwin)
	# echo 'Mac OS X'
	;;

Linux)
	;;

CYGWIN* | MINGW32* | MSYS* | MINGW*)
	# echo 'MS Windows'
	;;
*)
	# echo 'Other OS'
	;;
esac
