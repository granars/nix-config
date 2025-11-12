{ config, pkgs, lib, vars, ... }:
let
  wallpaper = ../../../../../../fluff/wallpapers/wallpaper.jpg;
in

{
  imports =
    [

    ];

  # System packages
  environment.systemPackages = with pkgs; [
    # This writes the override config file into the Breeze theme directory
    (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
      [General]
      background=${wallpaper}
      type=image
    '')
    kdePackages.qrca
  ];

  # Fingerprint
  security.pam.services.sddm.fprintAuth = true;
  security.pam.services.kde.fprintAuth = true;
  
  # Enable and configure SDDM 
  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    theme = "breeze";
    wayland.enable = true;
  };

  # Enable the KDE Plasma Desktop Environment
  services.desktopManager.plasma6.enable = true;

  # Enable KDE Connect
  programs.kdeconnect.enable = true;

  # Excluding some KDE applications from the default install
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    ark
    baloo-widgets
    elisa
    kate
    khelpcenter
    krdp
    plasma-browser-integration
  ];
}