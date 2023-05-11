#plugin manager
#!/bin/sh
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# history
HISTFILE=~/.zsh_history

#enable fzf keybindings installed by nix
if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

# source
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/secrets.zsh"

# plugins
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/vim"
plug "zap-zsh/zap-prompt"
plug "zap-zsh/exa"
# for nix
plug "chisui/zsh-nix-shell" "4eb69b0" #v0.5 works, but 0.6 I got an error
plug "nix-community/nix-zsh-completions"

# keybinds
# ctrl+space to accept suggestion
bindkey '^ ' autosuggest-accept

export PATH="$HOME/.local/bin":$PATH

if command -v bat &> /dev/null; then
  alias cat="bat -pp --theme \"Visual Studio Dark+\"" 
  alias catt="bat --theme \"Visual Studio Dark+\"" 
fi

# atuin: sqlite command history
eval "$(atuin init zsh --disable-ctrl-r --disable-up-arrow)"
bindkey '^e' _atuin_search_widget

plug "zsh-users/zsh-syntax-highlighting" #must be source at the end, documentation said
