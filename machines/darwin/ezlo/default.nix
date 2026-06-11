{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
{
  environment.shellInit = ''
    ulimit -n 2048
  '';

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "none";
      upgrade = true;
    };
    prefix = "/opt/homebrew/";
    caskArgs = {
      no_quarantine = true;
    };
    brews = [
      "mas"
    ];
    casks = [
      "tailscale-app"
      "balenaetcher"
      "betterdisplay"
      "istat-menus"
      "home-assistant"
      "daisydisk"
      "signal"
      "prusaslicer"
      "raspberry-pi-imager"
      "whatsapp"
      "nextcloud"
      "obsidian"
      "zed"
      ];
    masApps = {
      "CotEditor" = 1024640650;
      "Scrobbles" = 1344679160;
      "Infuse" = 1136220934;
      "Wipr" = 1662217862;
      "Noir" = 1592917505;
      "RollerCoaster Tycoon® Classic+" = 6702028686;
      "DaVinci Resolve" = 571213070;
    };
   };
    environment.systemPackages = with pkgs; [
      bitwarden-desktop
      git
      git-crypt
      caligula
      astroterm
      pastel
      upscayl
      vesktop
    ];

    services.ollama = {
      enable = true;
      host = "0.0.0.0";
    };

    fonts.packages = [
      pkgs.nerd-fonts.jetbrains-mono
    ];

    nixpkgs.config.permittedInsecurePackages = [
      "electron-39.8.10"
    ];

  #services.nix-daemon.enable = lib.mkForce true;

  system.primaryUser = "granar";
  system.stateVersion = 5;
}
