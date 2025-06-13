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
    ../../dots/vscode/default.nix
    ../../dots/plasma/default.nix
  ];
}