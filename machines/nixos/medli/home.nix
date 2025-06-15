{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
    inputs.catppuccin.homeModules.catppuccin
    ../../../dots/plasma/default.nix
    ../../../dots/catppuccin/default.nix
  ];

}
