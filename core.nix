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
    stow #symlink manager
    tldr
    tmux
    tree
    wget
    yq-go # yaml, json and xml processor
    zoxide
    zsh

    # programming languages
    nodejs
    cargo
    rustc

    # # GUI apps
    vscode # binary name: code
    # wezterm #need to build, takes too long
    alacritty
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };
  };
}
