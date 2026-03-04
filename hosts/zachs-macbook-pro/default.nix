{ config, lib, pkgs, inputs, username, ... }:

{
  imports = [
    ../../modules/darwin/discord.nix
    ../../modules/darwin/ghostty.nix
    ../../modules/darwin/homebrew.nix
    ../../modules/darwin/obsidian.nix
    ../../modules/darwin/spotify.nix
    ../../modules/darwin/system-preferences.nix
    ../../modules/darwin/zen-browser.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.fish.enable = true;

  networking.hostName = "Zachs-MacBook-Pro";

  system.primaryUser = username;
  system.stateVersion = 5;
}
