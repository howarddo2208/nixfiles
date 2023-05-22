#!/bin/sh
# HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
export EDITOR="nvim"
export PATH="$HOME/.local/bin":$PATH

export NIXPKGS_ALLOW_UNFREE=1
# quick navigate folder
eval "$(zoxide init zsh)"

# direnv: auto switch dev environment
eval "$(direnv hook zsh)"
