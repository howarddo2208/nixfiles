This is my personal nixfiles

1. clone into ~/nixfiles and cd into it
2. copy nix.conf `cp -r dotfiles/nix ~/.config/nix`
3. run `nix run . -- switch -f home-{system}.nix`
4. install [zsh-zap](https://github.com/zap-zsh/zap) as I use it to manage zsh plugins: `zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1`
5. set default shell to `zsh` if you are on linux with bash default `command -v zsh | sudo tee -a /etc/shells && chsh -s "$(command -v zsh)"`. reference: https://unix.stackexchange.com/questions/111365/how-to-change-default-shell-to-zsh-chsh-says-invalid-shell
6. first time config
    - login to github + ssh for it: `gh auth login`
    - tmux: install plugin manager `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm` then `tmux source ~/.tmux.conf -> `tmux attach` -> `<C-a> + I`
    - install programming languages:
        - node: `fnm install --lts`
        - [rust](https://www.rust-lang.org/tools/install): `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
    - may need to install some lsp for neovim with `:Mason`
7. ??? Profits ???

install wezterm with current OS package manager
## TODOS
- [] zsh-zap install config
- [] split modules for macos / linux setup
