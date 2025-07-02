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
    brewPrefix = "/opt/homebrew/bin";
    caskArgs = {
      no_quarantine = true;
    };
    brews = [
      "mas"
    ];
    casks = [
      "tailscale"
      "balenaetcher"
      "betterdisplay"
      "1password"
      "istat-menus"
      "home-assistant"
      "daisydisk"
      "prusaslicer"
      "raspberry-pi-imager"
      "whatsapp"
      "visual-studio-code"
      "nextcloud"    
      "runelite"
      "jagex"
      "obsidian"
      ];
    masApps = {
      "CotEditor" = 1024640650;
      "Scrobbles" = 1344679160;
      "Infuse" = 1136220934;
      "Wipr" = 1662217862;
      "Noir" = 1592917505;
      "RollerCoaster Tycoon® Classic+" = 6702028686;
    };
   };
    environment.systemPackages = with pkgs; [
      bitwarden-desktop
      ollama
      git
      git-crypt
      caligula
      astroterm
      pastel
      discord
      upscayl
    ];

    services.ollama = {
      enable = true;
    };

    fonts.packages = [
      pkgs.nerd-fonts.jetbrains-mono
    ];

  #services.nix-daemon.enable = lib.mkForce true;

  system.primaryUser = "granar";
  system.stateVersion = 5;
}