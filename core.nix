{ config, pkgs, libs, lib, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = [
    # dev environment apps
    pkgs.atuin
    pkgs.fd
    pkgs.fzf
    pkgs.ffmpeg
    pkgs.git
    pkgs.neovim
    pkgs.fontconfig
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "Hack" "JetBrainsMono"]; })
    pkgs.catimg
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
    pkgs.lazydocker
    pkgs.yq-go # yaml, json and xml processor
    pkgs.bash
    pkgs.tmux
    pkgs.tldr
    pkgs.zsh
  ];

  programs = {
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
