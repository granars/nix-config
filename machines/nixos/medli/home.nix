{ ... }:
let
  home = {
    username = "granar";
    homeDirectory = "/home/granar";
    stateVersion = "25.05";
  };
in
{
  home = home;

  imports = [
    ../../../dots/vscode/default.nix
  ];

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}