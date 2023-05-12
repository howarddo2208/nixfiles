This is my personal nixfiles

1. clone into ~/nixfiles and cd into it
2. copy nix.conf `cp dotfiles/nix/nix.conf ~/.config/nix/nix.conf`
3. run `home-manager switch -f home.nix`
4. first time config
    - neovim: add GITHUB_AUTH_TOKEN and change `secrets.example.zsh` to `secrets.zsh`
    - tmux: install plugins by `tmux attach` -> `<C-a> + I`
5. ??? Profits ???

## TODOS
- [] zsh-zap install config
- [] split modules for macos / nixOS setup
