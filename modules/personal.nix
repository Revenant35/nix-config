{ pkgs, ... }:

{
  # Packages specific to personal workstation
  environment.systemPackages = [
    pkgs.brave
  ];
}
