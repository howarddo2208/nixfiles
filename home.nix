{ config, pkgs, libs, lib, ... }:

let
  optionals = lib.optionals;
in
{
  # set username and home directory based on if im on linux or darwin
  home.username = "howard";
  home.homeDirectory = if isLinux then "/home/howard" else "/Users/howard";

  home.stateVersion = "23.05";

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "Hack" "JetBrainsMono" ]; })
    atuin # command history
    bash
    bat
    chafa # display image in terminal
    # viu # if don't want to use chafa
    cht-sh
    rlwrap
    exa
    fd
    fzf
    gh
    git
    lazydocker
    lazygit
    neovim
    tree-sitter
    ripgrep
    tldr
    tmux
    tmux-sessionizer
    tree
    urlscan
    vifm
    wget
    yq-go # yaml, json and xml processor
    jq
    zoxide # quick directory jumper
    zsh
    btop
    ffmpeg
    nix-prefetch-github
    starship
    stow #symlink manager, use this to sync dotfiles to current machine
    delta # syntax highlighting for git
  ]

  programs.home-manager.enable = true;
  programs = {
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };
  };
}

# other programs I use but not in dev setup but prefer to install through other package managers or not available on nix
  # CLI apps
    # bleachbit # disk cleaner, file shredder
    # exiftool
    # pandoc # convert docs
    # yt-dlp # youtube downloader
    # ytfzf # watch youtube from terminal
    # ytmdl # music downloader
    # sc-im #spreadsheet in the terminal
    # spoof-mac # mac address spoofer

  # programming languages & sdk
    # nodejs
    # typescript
    # yarn
    # nodePackages.pnpm
    # rustup

  # GUI apps
    # calibre
    # darktable
    # gimp # photo editor
    # audacity # audio edit
    # mpv # vide player
    # sioyek # pdf viewer
    # alacritty
    # kitty
    # qbittorrent
    # lapce
    # brave
    # libreoffice-qt
    # libsForQt5.kdenlive
    # mullvad-browser
    # obs-studio
    # thunderbird
    # veracrypt

  # for Linux only
    # fontconfig # for my arch linux
    # noto-fonts-emoji #to display logseq emoji correctly on linux
    # ibus-engines.bamboo #my vietnamese keyboard
    # xclip # for neovim in case not yet installed

  # for macOS only
    # gnugrep # for nix-direnv
    # pngpaste # for neovim clipboard-image
    # raycast
    # HOMEBREW SECTION
    # pidof (for one of my fzf script, cheatfzf)
    # stats
    # karabiner-elements #install from web is better
    # amethyst
