{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    ../../../dots/catppuccin/default.nix
  ];

  
}
