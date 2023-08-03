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
    # bash
    bat
    chafa
    # viu # currently I u
    cht-sh
    rlwrap
    exa
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
    stow #symlink manager

    # programming languages & sdk
    nodejs
    yarn
    nodePackages.pnpm
    rustup
  ]
  ++ (optionals isGraphical [
    darktable
    gimp # photo editor
    audacity # audio edit
    mpv # vide player
    sioyek # pdf viewer
    alacritty
    kitty
    qbittorrent
  ])
  ++ (optionals isLinux [
    ibus-engines.bamboo #my vietnamese keyboard
    xclip # for neovim in case not yet installed
  ])
  ++ (optionals (isLinux && isGraphical) [
    digikam
    brave
    # firefox # with betterfox harden
    libreoffice-qt
    libsForQt5.kdenlive
    mullvad-browser
    obs-studio
    thunderbird
  ])
  ++ (optionals isDarwin [
    gnugrep # for nix-direnv
    pngpaste # for neovim clipboard-image
    # karabiner-elements #install from web is better
    # GUI apps is stored at ~/.nix-profile/Applications
    # pidof (for one of my fzf script, cheatfzf, but only available on homebrew for now)
    raycast
    # librewolf # not available on nixpkgs for mac yet
  ])
  ++ (optionals useVM [
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
