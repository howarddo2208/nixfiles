#!/bin/sh
# HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="nvim"
export PATH="$HOME/.local/bin":$PATH
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
export BAT_THEME="Catppuccin-macchiato"

export NIXPKGS_ALLOW_UNFREE=1
