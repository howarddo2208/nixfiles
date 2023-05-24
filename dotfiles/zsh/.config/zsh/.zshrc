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
export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

# source
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/exports.zsh"
source "$HOME/.config/zsh/eval.zsh"

# plugins
plug "zap-zsh/supercharge"
plug "zap-zsh/vim"
plug "zap-zsh/exa"
plug "zsh-users/zsh-autosuggestions"
# for nix
plug "chisui/zsh-nix-shell" 
plug "nix-community/nix-zsh-completions"

# keybinds
# ctrl+space to accept suggestion
bindkey '^ ' autosuggest-accept
bindkey '^e' _atuin_search_widget

export PATH="$HOME/.local/bin":$PATH

if command -v bat &> /dev/null; then
  alias cat="bat -pp --theme \"Visual Studio Dark+\"" 
  alias catt="bat --theme \"Visual Studio Dark+\"" 
fi


# Load and initialise completion system
autoload -Uz compinit compinit
plug "zsh-users/zsh-syntax-highlighting" #must be source at the end, documentation said
source ~/.config/zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
