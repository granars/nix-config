{ config, pkgs, lib, vars, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../../modules/beszel
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Fingerprint
  services.fprintd.enable = true;

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

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = false;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
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

  # Configure console keymap
  console.keyMap = "uk";

  # Disable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Beszel Agent Key
  users.users."granar".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE+Y6wfEc7+Qh0ZAJ6Bzkzl+I+WEUMn1kFQDfMKg5n3Q"
  ]; 

  # Beszel Service
  services.beszel-agent = {
    enable = true;
    key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE+Y6wfEc7+Qh0ZAJ6Bzkzl+I+WEUMn1kFQDfMKg5n3Q";
  };

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "granar" ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    maliit-keyboard
    nwg-drawer
    discord
    easyeffects
    firefox
    caligula
    astroterm
    pastel
    obsidian
    nextcloud-client
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
}