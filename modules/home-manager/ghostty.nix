{ config, lib, pkgs, ... }:

{
  # Ghostty config (installed via homebrew on macOS)
  xdg.configFile = {
    "ghostty/config".text = ''
      shell-integration = fish
      command = ${lib.getExe pkgs.fish}
      background-opacity = 0.85
      theme = tokyo-night-moon
      font-family = JetBrainsMono Nerd Font Mono
    '';

    "ghostty/themes".source = ./ghostty/themes;
  };
}
