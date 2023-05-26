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
    nap # code snippet manager
    neovim
    nix-prefetch-github
    noto-fonts-emoji #to display logseq emoji correctly
    rbenv
    ripgrep
    skate #personal key-value store
    stow #symlink manager
    thefuck
    tldr
    tmux
    tmux-sessionizer
    tree
    vifm
    wget
    yq-go # yaml, json and xml processor
    zoxide
    zsh

    # programming languages
    nodejs
    nodePackages.pnpm
    cargo
    rustc

    # # GUI apps
    vscode # binary name: code
    # wezterm #need to build, takes too long
    # alacritty
    kitty
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
