{ config, pkgs, libs, ... }: {
  home.username = "tanhopdo"; #change to your username
  home.homeDirectory = "/Users/tanhopdo"; # /home/username on linux, /Users/username on macos
  home.stateVersion = "22.11"; # To figure this out you can comment out the line and see what version it expected.
  programs.home-manager.enable = true;

  imports = [
    ./core.nix
  ];

  home.packages = [

    # # GUI, utility apps
    # pkgs.syncthing
    # pkgs.logseq

    # macos specific
    pkgs.gnugrep # for nix-direnv
    pkgs.karabiner-elements
    # pkgs.raycast
  ];
}
