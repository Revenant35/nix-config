{ pkgs, ... }:

{
  # Packages specific to VU workstation
  environment.systemPackages = [
    pkgs.nodejs_20
  ];
}
