# atuin: sqlite command history
eval "$(atuin init zsh --disable-ctrl-r --disable-up-arrow)"

eval $(thefuck --alias)

eval "$(starship init zsh)"
# quick navigate folder
eval "$(zoxide init zsh)"

# direnv: auto switch dev environment
eval "$(direnv hook zsh)"
