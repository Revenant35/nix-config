{ pkgs, ... }:

{
  # Fonts
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  nixpkgs.config.allowUnfree = true;

  # Packages shared across all systems
  environment.systemPackages = [
    pkgs.vim
    pkgs.jetbrains-toolbox
    pkgs.fastfetch
    pkgs.starship
    pkgs.zoxide
    pkgs.obsidian
    pkgs.spotify
    pkgs.brave
    pkgs.lazygit
    pkgs.claude-code
    pkgs.android-tools
    pkgs.javaPackages.compiler.temurin-bin.jdk-25
    pkgs.stow
  ];

  # Homebrew packages
  homebrew = {
    enable = true;
    brews = [
      # "spotify_player"
    ];
    casks = [
      "ghostty"
      #"brave-browser"
    ];
    onActivation.cleanup = "zap";
  };

  # Enable fish shell
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      starship init fish | source
      enable_transience
      zoxide init fish | source
      alias drs="sudo darwin-rebuild switch"
      export XDG_CONFIG_HOME="$HOME/.config"
    '';
  };

  # Set fish as default shell for user
  users.users.zachbrown.shell = pkgs.fish;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
}
