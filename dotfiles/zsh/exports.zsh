#!/bin/sh
# HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
export EDITOR="nvim"
export PATH="$HOME/.local/bin":$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH="$HOME/.local/share/neovim/bin":$PATH

# pnpm
export PNPM_HOME="/Users/tanhopdo/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# tmuxifier
export PATH="$HOME/.tmux/plugins/tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

# fast node version manager
eval "$(fnm env)"

# quick navigate folder
eval "$(zoxide init zsh)"

# ruby version manager rbenv
eval "$(rbenv init - zsh)"

# direnv: auto switch dev environment
eval "$(direnv hook zsh)"
