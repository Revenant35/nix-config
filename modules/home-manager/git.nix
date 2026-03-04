{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      init.defaultBranch = "main";
      core.editor = "vim";
      merge.conflictStyle = "zdiff3";
    };
  };
}
