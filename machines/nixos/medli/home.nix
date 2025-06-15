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
    ../../dots/plasma/default.nix
  ];

}