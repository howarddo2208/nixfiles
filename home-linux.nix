{ config, pkgs, libs, lib, ... }: {
  home.username = "howard"; #change to your username
  home.homeDirectory = "/home/howard"; # /home/username on linux, /Users/username on macos
  home.stateVersion = "22.11"; # To figure this out you can comment out the line and see what version it expected.
  programs.home-manager.enable = true;

  imports = [
    ./core.nix
  ];

  home.packages = with pkgs; [
    # linux specific
    ibus-engines.bamboo #my vietnamese keyboard
    xclip # for neovim in case not yet installed
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
