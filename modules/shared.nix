{ pkgs, ... }:

{
  # Packages shared across all systems
  environment.systemPackages = [
    pkgs.vim
  ];

  # Homebrew packages
  homebrew = {
    enable = true;
    brews = [
      "fastfetch"
      "starship"
    ];
    casks = [
      "ghostty"
    ];
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
}
