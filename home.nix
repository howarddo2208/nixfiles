{ config, pkgs, libs, lib, ... }:

let
  optionals = lib.optionals;
  configs = import ./configs.nix;
  isLinux = configs.isLinux;
  isDarwin = !isLinux;
  useVM = configs.useVM;
  isGraphical = configs.isGraphical;
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
    bleachbit # disk cleaner, file shredder
    chafa
    # viu # currently I u
    cht-sh
    rlwrap
    exa
    # exiftool
    fd
    fish
    fontconfig
    fzf
    gh
    git
    lazydocker
    lazygit
    neovim
    tree-sitter
    noto-fonts-emoji #to display logseq emoji correctly
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
    zoxide
    zsh
    btop
    ffmpeg
    mediainfo # view media metadata
    musikcube #music player
    nix-prefetch-github
    pandoc # convert docs
    newsboat # terminal RSS reader
    skate #personal key-value store
    taskell #kanban task manager in the terminal
    yt-dlp # youtube downloader
    ytfzf # watch youtube from terminal
    ytmdl # music downloader
    sc-im #spreadsheet in the terminal
    starship
    stow #symlink manager
    spoof-mac # mac address spoofer

    # programming languages & sdk
    nodejs
    typescript
    yarn
    nodePackages.pnpm
    rustup
  ]
  ++ (optionals isGraphical [
    # calibre
    # darktable
    gimp # photo editor
    audacity # audio edit
    mpv # vide player
    sioyek # pdf viewer
    alacritty
    kitty
    qbittorrent
    lapce
  ])
  ++ (optionals isLinux [
    ibus-engines.bamboo #my vietnamese keyboard
    xclip # for neovim in case not yet installed
  ])
  ++ (optionals (isLinux && isGraphical) [
    brave
    # firefox # with betterfox harden
    libreoffice-qt
    libsForQt5.kdenlive
    mullvad-browser
    obs-studio
    thunderbird
    veracrypt
  ])
  ++ (optionals isDarwin [
    # GUI apps is stored at ~/.nix-profile/Applications
    gnugrep # for nix-direnv
    pngpaste # for neovim clipboard-image
    raycast
    # HOMEBREW SECTION
    # pidof (for one of my fzf script, cheatfzf)
    # stats
    # karabiner-elements #install from web is better
    # amethyst
  ])
  ++ (optionals (useVM && isLinux) [
    qemu
  ]);

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
