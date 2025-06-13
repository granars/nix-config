{ ... }:
let
  home = {
    username = "granar";
    homeDirectory = "/home/granar";
    stateVersion = "25.05";
  };
in
{

  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home = home;

  imports = [
    ../../dots/zsh/default.nix
#    ../../dots/vscode/default.nix
    ./gitconfig.nix
  ];

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}