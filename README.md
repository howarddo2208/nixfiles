This is my personal nixfiles

1. clone into ~/nixfiles and cd into it
2. copy nix.conf `cp -r dotfiles/nix ~/.config/nix`
3. run `nix run . -- switch -f home-{system}.nix`
4. install [zsh-zap](https://github.com/zap-zsh/zap) as I use it to manage zsh plugins: `zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1`
5. set default shell to `zsh` if you are on linux with bash default `command -v zsh | sudo tee -a /etc/shells && chsh -s "$(command -v zsh)"`. reference: https://unix.stackexchange.com/questions/111365/how-to-change-default-shell-to-zsh-chsh-says-invalid-shell
6. first time config
    - neovim: add `GITHUB_AUTH_TOKEN` after `cp ~/.config/zsh/secrets.example.zsh ~/.config/zsh/secrets.zsh` for neovim github codesearch plugin
    - tmux: install plugins by `tmux attach` -> `<C-a> + I`
7. ??? Profits ???

## TODOS
- [] zsh-zap install config
- [] split modules for macos / nixOS setup
