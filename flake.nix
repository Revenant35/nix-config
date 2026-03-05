{
  description = "Nix configuration for personal machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, ... }:
    let
      systems = {
        personal = {
          hostname = "Zachs-MacBook-Pro";
          system = "aarch64-darwin";
          username = "zachbrown";
        };
        linux-desktop = {
          hostname = "fedora";
          system = "x86_64-linux";
          username = "zachbrown";
        };
      };

      mkDarwinConfiguration = { hostname, system, username }: nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = { inherit inputs username; };
        modules = [
          ./hosts/${nixpkgs.lib.toLower hostname}
        ];
      };

      mkHomeConfiguration = { system, username, hostname ? null }: home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        extraSpecialArgs = { inherit inputs username; };
        modules = [
          inputs.zen-browser.homeModules.default
          ./home/${username}
        ];
      };
    in
    {
      darwinConfigurations = {
        "Zachs-MacBook-Pro" = mkDarwinConfiguration systems.personal;
      };

      homeConfigurations = {
        "zachbrown@Zachs-MacBook-Pro" = mkHomeConfiguration systems.personal;
        "zachbrown@fedora" = mkHomeConfiguration systems.linux-desktop;
      };
    };
}
