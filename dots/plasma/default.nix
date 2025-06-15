{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{

  home.packages = with pkgs; [ 
    (catppuccin-kde.override {
      flavour = ["mocha"];
      accents = ["lavender"];
    })
    kara
    kde-rounded-corners
    kdePackages.krohnkite
    kdotool
    tela-circle-icon-theme
    ];

  programs = {
    plasma = {
      enable = true;
    
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";

       };
    };
  };
}
