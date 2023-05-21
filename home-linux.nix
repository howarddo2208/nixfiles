{ config, pkgs, libs, lib, ... }: {
  home.username = "howard"; #change to your username
  home.homeDirectory = "/home/howard"; # /home/username on linux, /Users/username on macos
  home.stateVersion = "22.11"; # To figure this out you can comment out the line and see what version it expected.
  programs.home-manager.enable = true;

  imports = [
    ./core.nix
  ];

  home.packages = [
    # utility apps
    # pkgs.ibus-engines.bamboo
    # pkgs.bitwarden-cli #install with npm instead, nix taks too long: `npm install -g @bitwarden/cli`
    pkgs.noto-fonts-emoji #to display my logseq emoji correctly
    pkgs.xclip # for neovim in case not yet installed

    # GUI apps I use, I will install them on with current distro package manager, since app installed by nix won't get indexed for searching
    # reference: https://github.com/nix-community/home-manager/issues/1439
    # pkgs.syncthing
    # pkgs.logseq
    # pkgs.wezterm
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
