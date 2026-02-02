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
  ];

  # Homebrew packages
  homebrew = {
    enable = true;
    brews = [
      "fastfetch"
      "starship"
      "zoxide"
      # "spotify_player"
    ];
    casks = [
      "ghostty"
      "obsidian"
      "spotify"
      "brave-browser"
      "claude-code"
    ];
    onActivation.cleanup = "zap";
  };

  # Enable fish shell
  programs.fish = {
    enable = true;
    loginShellInit = ''
      fish_add_path /opt/homebrew/bin
    '';
    interactiveShellInit = ''
      starship init fish | source
      zoxide init fish | source
      alias drs="sudo darwin-rebuild switch"
    '';
  };

  # Set fish as default shell for user
  users.users.zachbrown.shell = pkgs.fish;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
}
