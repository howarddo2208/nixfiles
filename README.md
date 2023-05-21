# My personal nix files

If you want to use this, highly recommend forking it and change username/home directory, etc. I plan to write a detail guide soon

## Instructions migrating (for a fork)
0. Install nix from `nixos.org`
1. Clone the repo to home directory
2. run `nix run "github:howarddo2208/nixfiles#homeConfigurations.{macos|linux}.activationPackage" --extra-experimental-features nix-command --extra-experimental-features flakes` change uri to your repo.
3. Run `cd ~/nixfiles/dotfiles && stow -vSt ~ *` to create symlink dotfiles, add `-n` flag to `stow` to view simulation before symlink. I won't manage configuration purely with Nix.
4. first time config
    - install [zsh-zap](https://github.com/zap-zsh/zap) as I use it to manage zsh plugins: `zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1`, if you don't install it, there will be errors about the plug keyword when switching to `zsh`
    - set default shell to `zsh` if you are on linux with bash default `command -v zsh | sudo tee -a /etc/shells && chsh -s "$(command -v zsh)"`. [reference](https://unix.stackexchange.com/questions/111365/how-to-change-default-shell-to-zsh-chsh-says-invalid-shell). The default shell emulator maynot switch to zsh because it was hard-coded to bash, then you may want to tweak the setting, or install another shell emulator, I recommend [wezterm](https://github.com/wez/wezterm) 
    - login to github + ssh for it: `gh auth login`
    - tmux: install plugin manager `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm` then `tmux source ~/.tmux.conf` -> `tmux attach` -> `<C-a> + I`
    - login into atuin + sync (command hisotry): `atuin login -u username` -> `atuin sync`
    - may need to install some lsp for neovim with `:Mason`
5. Each time changing the configs: `cd ~/nixfiles && home-manager switch --flake ".#{macos|linux}"` or alias `hms`
6. ??? Profits ???

install wezterm with current OS package manager
## TODOS
- [] remove zsh-zap
- [x] split modules for macos / linux setup
