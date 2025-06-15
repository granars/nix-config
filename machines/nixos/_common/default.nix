{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  system.stateVersion = "25.05";
  system.autoUpgrade = {
    enable = true;
    flake = "/etc/nixos\\?submodules=1";
    flags = [
      "--update-input"
      "nixpkgs"
      "-L"
    ];
    dates = "Sat *-*-* 06:00:00";
    randomizedDelaySec = "45min";
    allowReboot = true;
  };

  imports = [
    ./nix
#    ./secrets
  ];

  time.timeZone = "Europe/London";

  # users.users = {
  #   root = {
  #     initialHashedPassword = config.age.secrets.hashedUserPassword.path;
  #   };
  # };
  
  services.openssh = {
    enable = lib.mkDefault true;
    settings = {
      PasswordAuthentication = lib.mkDefault false;
      LoginGraceTime = 0;
      PermitRootLogin = "no";
    };
    ports = [ 69 ];
  };

  programs.git.enable = true;

  security = {
    doas.enable = lib.mkDefault false;
    sudo = {
      enable = lib.mkDefault true;
      wheelNeedsPassword = lib.mkDefault false;
    };
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "granar" ];
  };

  environment.systemPackages = with pkgs; [
    wget
    iperf3
    btop
    iotop
    nmap
    lm_sensors
    beszel
    fastfetch
  ];

}