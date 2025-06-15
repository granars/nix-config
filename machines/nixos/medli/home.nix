{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ../../../dots/plasma/default.nix
  ];

}
