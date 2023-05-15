{ config, pkgs, libs, lib, ... }: {
  home.username = "howard"; #change to your username
  home.homeDirectory = "/home/howard"; # /home/username on linux, /Users/username on macos
  home.stateVersion = "22.11"; # To figure this out you can comment out the line and see what version it expected.
  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = [
    pkgs.atuin
    pkgs.fd
    pkgs.fzf
    pkgs.ffmpeg
    pkgs.git
    pkgs.neovim
    pkgs.fontconfig
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "Hack" "JetBrainsMono"]; })
    pkgs.imgcat
    pkgs.btop
    pkgs.ripgrep
    pkgs.tree
    pkgs.mc
    pkgs.gh
    pkgs.exa
    pkgs.rbenv
    pkgs.zoxide
    pkgs.fnm
    pkgs.bat
    pkgs.lazygit
    pkgs.yq-go # yaml, json and xml processor
    pkgs.bash
    pkgs.tmux

    # GUI apps I use, I will install them on with current distro package manager, since app installed by nix won't get indexed for searching
    # reference: https://github.com/nix-community/home-manager/issues/1439
    # pkgs.syncthing
    # pkgs.logseq
    # pkgs. wezterm
  ];

  programs = {
    zsh.enable = true;
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };
  };

  # symlink dotfiles, ensure that any changes while running programs are not lost
  home.file = {
    ".tmux.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.tmux.conf;
    };
    ".zshenv" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/.zshenv;
    };
    ".config/zsh" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/zsh;
      recursive = true;
    };
    ".gitconfig" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/git/.gitconfig;
    };
    ".gitconfig-work" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/git/.gitconfig-work;
    };
    ".config/karabiner" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/karabiner;
      recursive = true;
    };
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/nvim;
      recursive = true;
    };
    ".config/mc" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/mc;
      recursive = true;
    };
    ".config/wezterm" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/wezterm;
      recursive = true;
    };
  };
}
