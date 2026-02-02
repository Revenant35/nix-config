{ pkgs, ... }:

{
  # Packages shared across all systems
  environment.systemPackages = [
    pkgs.vim
  ];

  # Homebrew packages
  homebrew = {
    enable = true;
    brews = [
      "fastfetch"
      "starship"
    ];
    casks = [
      "ghostty"
    ];
  };

  # Enable fish shell
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      starship init fish | source
    '';
  };

  # Set fish as default shell for user
  users.users.zachbrown.shell = pkgs.fish;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
}
