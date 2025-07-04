{ config, pkgs, lib, vars, ... }:
let
  wallpaper = ../../../fluff/wallpapers/wallpaper.jpg;
  beszelkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE+Y6wfEc7+Qh0ZAJ6Bzkzl+I+WEUMn1kFQDfMKg5n3Q";
in
{
  imports =
    [
      ./hardware-configuration.nix
    ];
 
  # System packages
  environment.systemPackages = with pkgs; [
    # This writes the override config file into the Breeze theme directory
    (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
      [General]
      background=${wallpaper}
      type=image
    '')
    astroterm
    caligula
    easyeffects
    firefox
    maliit-keyboard
    mullvad-browser
    nextcloud-client
    obsidian
    pastel
    pipeline
    vesktop
  ];

  # Flatpak Packages
  services.flatpak.packages = [

  ];

  # Fonts configuration
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    roboto
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Fingerprint
  services.fprintd.enable = true;
  security.pam.services.sddm.fprintAuth = true;
  security.pam.services.login.fprintAuth = true;
  security.pam.services.kde.fprintAuth = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # IIO - Screen Rotation
  hardware.sensor.iio.enable = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices."luks-05afba07-5d9f-4227-af1e-3632c610ac33".device = "/dev/disk/by-uuid/05afba07-5d9f-4227-af1e-3632c610ac33";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "medli"; # Define your hostname.

  # Graphics
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # For Gen11+ Xe iGPU
      intel-vaapi-driver
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      vaapiVdpau        
      vpl-gpu-rt # QSV on 11th gen or newer
    ];
  };
  
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Power Tuning / Management
  powerManagement.powertop.enable = true; # enable powertop auto tuning on startup.
  services.system76-scheduler.settings.cfsProfiles.enable = true; # Better scheduling for CPU cycles - thanks System76!!!
  services.thermald.enable = true; # Enable thermald, the temperature management daemon. (only necessary if on Intel CPUs)

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session
  services.xserver.enable = false;

  # Enabe and configure SDDM 
  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    theme = "breeze";
  };

  # Enable the KDE Plasma Desktop Environment
  services.desktopManager.plasma6.enable = true;

  # Excluding some KDE applications from the default install
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    ark
    baloo-widgets
    elisa
    kate
    khelpcenter
    krdp
    plasma-browser-integration
    xwaylandvideobridge
  ];

  # Disable CUPS to print documents.
  services.printing.enable = false;

  # Beszel Agent Key
  users.users."granar".openssh.authorizedKeys.keys = [
    beszelkey
  ]; 

  # Beszel Service
  services.beszel-agent = {
    enable = true;
    key = beszelkey;
  };
}