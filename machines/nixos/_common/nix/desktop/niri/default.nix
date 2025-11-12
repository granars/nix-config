{ config, pkgs, lib, vars, inputs, ... }:
let
 # wallpaper = ../../../../../../fluff/wallpapers/wallpaper.jpg;
in

{
  imports =
    [
    ];
  
  # System packages
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${system}.default
    alacritty
  ];
    programs.niri.enable = true;
}