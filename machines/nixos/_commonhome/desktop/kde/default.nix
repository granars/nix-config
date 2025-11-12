{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
    ../../../../../dots/plasma/default.nix
    inputs.catppuccin.homeModules.catppuccin
    ../../../../../dots/catppuccin/default.nix
  ];

  
}