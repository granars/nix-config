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
    pkgs.quickshell
    alacritty
  ];
 
  # Enable and configure SDDM 
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  
    programs.niri.enable = true;
}