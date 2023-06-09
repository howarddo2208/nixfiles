{ config, pkgs, libs, lib, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # dev tools
    (nerdfonts.override { fonts = [ "FiraCode" "Hack" "JetBrainsMono" ]; })
    atuin # command history
    bash
    bat
    catimg
    cheat
    cht-sh
    rlwrap
    exa
    fd
    fish
    fontconfig
    fzf
    gh
    git
    kitty
    lazydocker
    lazygit
    neovim
    tree-sitter
    noto-fonts-emoji #to display logseq emoji correctly
    ripgrep
    thefuck
    tldr
    tmux
    tmux-sessionizer
    tree
    ueberzugpp
    urlscan
    vifm
    wget
    yq-go # yaml, json and xml processor
    zoxide
    zsh

    # utility apps
    btop
    ffmpeg
    gimp # photo editor
    mpv # vide player
    musikcube #music player
    newsboat # terminal RSS reader
    nix-prefetch-github
    pandoc # convert docs
    sc-im #spreadsheet in the terminal
    skate #personal key-value store
    sioyek # pdf viewer
    stow #symlink manager
    taskell #kanban task manager in the terminal
    yt-dlp # youtube downloader
    ytfzf # watch youtube from terminal
    ytmdl # music downloader
    rtorrent

    # programming languages & sdk
    nodejs
    yarn
    nodePackages.pnpm
    rustup
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

  programs.starship =
    let
      flavour = "macchiato"; # One of `latte`, `frappe`, `macchiato`, or `mocha`
    in
    {
      enable = true;
      settings = {
        # Other config here
        format = "$all"; # Remove this line to disable the default prompt format
        palette = "catppuccin_${flavour}";
      } // builtins.fromTOML (builtins.readFile
        (pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "starship";
            rev = "3e3e54410c3189053f4da7a7043261361a1ed1bc"; # Replace with the latest commit hash
            sha256 = "soEBVlq3ULeiZFAdQYMRFuswIIhI9bclIU8WXjxd7oY=";
          } + /palettes/${flavour}.toml));
    };
}
