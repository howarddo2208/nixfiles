{ config, pkgs, libs, ... }: {
  home.username = "tanhopdo"; #change to your username
  home.homeDirectory = "/Users/tanhopdo"; # /home/username on linux, /Users/username on macos
  home.stateVersion = "22.11"; # To figure this out you can comment out the line and see what version it expected.
  programs.home-manager.enable = true;

  imports = [
    ./core.nix
  ];

  home.packages = with pkgs; [
    # macos specific
    gnugrep # for nix-direnv
    pngpaste # for neovim clipboard-image
    karabiner-elements
    # raycast
  ];
}
