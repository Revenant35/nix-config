{ config, lib, pkgs, ... }:

{
  # Ghostty config (installed via homebrew on macOS)
  xdg.configFile = {
    "ghostty/config".text = ''
      shell-integration = fish
      command = /run/current-system/sw/bin/fish
      background-opacity = 0.85
      theme = tokyo-night-moon
      font-family = JetBrains Mono
    '';

    "ghostty/themes".source = ./ghostty/themes;
  };
}
