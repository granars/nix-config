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
#    ./filesystems
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
    # hostKeys = [
    #   {
    #     path = "/persist/ssh/ssh_host_ed25519_key";
    #     type = "ed25519";
    #   }
    #   {
    #     path = "/persist/ssh/ssh_host_rsa_key";
    #     type = "rsa";
    #     bits = 4096;
    #   }
    # ];
  };

  programs.git.enable = true;
  programs.htop.enable = true;

  security = {
    doas.enable = lib.mkDefault false;
    sudo = {
      enable = lib.mkDefault true;
      wheelNeedsPassword = lib.mkDefault false;
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    iperf3
    btop
    iotop
    nmap
    lm_sensors
  ];

}