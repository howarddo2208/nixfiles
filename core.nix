{ config, pkgs, libs, lib, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # dev environment apps
    (nerdfonts.override { fonts = [ "FiraCode" "Hack" "JetBrainsMono" ]; })
    atuin
    bash
    bat
    btop
    catimg
    cht-sh
    exa
    fd
    ffmpeg
    fontconfig
    fzf
    gh
    git
    lazydocker
    lazygit
    mc
    neovim
    nodejs
    rbenv
    ripgrep
    tldr
    tmux
    tree
    yq-go # yaml, json and xml processor
    zoxide
    zsh
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
      source = ./dotfiles/.tmux.conf;
    };
    ".zshenv" = {
      source = ./dotfiles/.zshenv;
    };
    ".config/zsh" = {
      source = ./dotfiles/zsh;
    };
    ".gitconfig" = {
      source = ./dotfiles/git/.gitconfig;
    };
    ".gitconfig-work" = {
      source = ./dotfiles/git/.gitconfig-work;
    };
    ".config/karabiner" = {
      source = ./dotfiles/karabiner;
    };
    ".config/nvim" = {
      source = ./dotfiles/nvim;
    };
    ".config/mc" = {
      source = ./dotfiles/mc;
    };
    ".config/wezterm" = {
      source = ./dotfiles/wezterm;
    };
  };
}
