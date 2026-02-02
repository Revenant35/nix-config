{ pkgs, ... }:

{
  # Packages shared across all systems
  environment.systemPackages = [
    pkgs.vim
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
}
