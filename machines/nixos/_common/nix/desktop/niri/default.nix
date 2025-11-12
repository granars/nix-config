{ config, pkgs, lib, vars, ... }:
let
 # wallpaper = ../../../../../../fluff/wallpapers/wallpaper.jpg;
in

{
  imports =
    [

    ];

  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.default
  ];
    
    programs.niri.enable = true;

}