This is my personal nixfiles

0. Install nix from `nixos.org`
1. clone into ~/nixfiles and cd into it: `git clone https://github.com/howarddo2208/nixfiles.git`
2. copy nix.conf `cp -r dotfiles/nix ~/.config/nix`
3. Change `home.username` and `home.homedirectory` to fit your system in `home-linux.nix` or `home-mac.nix`
4. run `nix run "nixfiles/#homeConfigurations.{macos|linux}.activationPackage"`
5. first time config
    - install [zsh-zap](https://github.com/zap-zsh/zap) as I use it to manage zsh plugins: `zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1`, if you don't install it, there will be errors about the plug keyword when switching to `zsh`
    - set default shell to `zsh` if you are on linux with bash default `command -v zsh | sudo tee -a /etc/shells && chsh -s "$(command -v zsh)"`. [reference](https://unix.stackexchange.com/questions/111365/how-to-change-default-shell-to-zsh-chsh-says-invalid-shell). The default shell emulator maynot switch to zsh because it was hard-coded to bash, then you may want to tweak the setting, or install another shell emulator, I recommend [wezterm](https://github.com/wez/wezterm) 
    - login to github + ssh for it: `gh auth login`
    - tmux: install plugin manager `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm` then `tmux source ~/.tmux.conf` -> `tmux attach` -> `<C-a> + I`
    - install programming languages:
        - [rust](https://www.rust-lang.org/tools/install): `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
    - may need to install some lsp for neovim with `:Mason`
6. Each time changing the configs: `home-manager switch --flake "nixfiles/#{macos|linux}"`
7. ??? Profits ???

install wezterm with current OS package manager
## TODOS
- [] zsh-zap install config
- [x] split modules for macos / linux setup
