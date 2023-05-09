{ pkgs, ... }: {
  home.username = "tanhopdo";
  home.homeDirectory = "/home/tanhopdo";
  home.stateVersion = "22.11"; # To figure this out you can comment out the line and see what version it expected.
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.atuin
    pkgs.fd
    pkgs.fzf
    pkgs.ffmpeg
    pkgs.neovim
    # pkgs.nerdfonts # need override
    pkgs.imgcat
    pkgs.btop
    pkgs.ripgrep
    pkgs.tree
    pkgs.mc
    pkgs.gh
    pkgs.exa
    pkgs.rbenv
    pkgs.zoxide
    pkgs.fnm
    pkgs.bat
    pkgs.lazygit
  ];

  # Install the gitconfig file, as .gitconfig in the home directory
  # home.file.".config/wezterm".source = ./gitconfig;
}
