{ pkgs, ... }:

{
  # Packages specific to VU workstation
  environment.systemPackages = [
    pkgs.nodejs_20
    pkgs.dotnetCorePackages.sdk_8_0_1xx-bin
  ];
}
