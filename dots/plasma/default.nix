{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{

  home.packages = with pkgs; [ grc ];

  programs = {
    plasma = {
      enable = true;
    
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";

       };
    };
  };
}
