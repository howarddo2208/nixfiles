{ config, pkgs, libs, ... }: {
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
    pkgs.karabiner-elements
  ];

  # TODO install wezterm without compile error
  #  programs.wezterm = {
  #   enable = true;
  #   extraConfig = ''
  #     local wezterm = require 'wezterm'
  #     return {
  #       font = wezterm.font 'JetBrainsMono Nerd Font Mono'
  #       color_scheme = 'GitHub Dark'
  #       window_background_opacity = 0.9
  #     }
  #   '';
  #  };

  # symlink dotfiles, ensure that any changes while running programs are not lost
  home.file = {
    ".config/karabiner" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/karabiner;
      recursive = true;
    };
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/nvim;
      recursive = true;
    };
    ".config/mc" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/mc;
      recursive = true;
    };
    ".config/wezterm" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/wezterm;
      recursive = true;
    };
  };
}
