if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx ATUIN_NOBIND "true"
    atuin init fish | source
    bind \ce _atuin_search

end

starship init fish | source
zoxide init fish | source

abbr -a -- ls 'exa --group-directories-first --icons'
abbr -a -- ll 'exa --group-directories-first --icons -lh --git'

abbr -a v 'nvim'
abbr -a vv 'nvim .'
abbr -a fishrc "nvim $FISHRC"
abbr -a nvimrc 'nvim ~/.config/nvim/'

set -Ux FISHRC "~/.config/fish/config.fish"
set -Ux XDG_CONFIG_HOME "$HOME/.config"
set -Ux MANPAGER 'nvim +Man!'
set -Ux MANWIDTH 999
set -Ux EDITOR "nvim"
set -Ux PATH "$HOME/.local/bin" $PATH
set -Ux PNPM_HOME "~/.local/share/pnpm"
set -Ux BAT_THEME "Catppuccin-macchiato"
set -Ux NIXPKGS_ALLOW_UNFREE 1
