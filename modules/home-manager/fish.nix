{ config, lib, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      hms = "home-manager switch --flake ~/nix";
      cd = "z";
      ls = "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions";
      cat = "bat";
    } // lib.optionalAttrs pkgs.stdenv.isDarwin {
      drs = "darwin-rebuild switch --flake ~/nix";
    };

    interactiveShellInit = ''
      # Run fastfetch on shell startup
      fastfetch
    '';
  };

  # Set XDG_CONFIG_HOME
  home.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  # fzf integration (auto-sources in fish)
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };
}
