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
    yq-go # yaml, json and xml processor
    zoxide
    zsh

    # programming languages
    nodejs
    cargo
    rustc

    # # GUI, utility apps
    # syncthing
    # logseq
    # vscode
    # wezterm
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };
  };
}
