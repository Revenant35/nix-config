{ config, lib, pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/master/doc/json_schema.json";
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "shell"
        "de"
        "theme"
        "cursor"
        "cpu"
        "gpu"
        "memory"
        "disk"
        "localip"
        "battery"
        "break"
        "colors"
      ];
    };
  };
}
