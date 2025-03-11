{
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
      cleanup = "zap";
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
      "iina"
      "tailscale"
      "raycast"
      "zen-browser"
      "balenaetcher"
      "1password"
      "istat-menus"
      "home-assistant"
      "daisydisk"
      "prusaslicer"
      "raspberry-pi-imager"
      "whatsapp"
      "visual-studio-code"
      "nextcloud"    
      "ollama"
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
    };
   };
    environment.systemPackages = with pkgs; [
      git
      git-crypt
      discord
      inputs.agenix.packages."${system}".default
    ];

    fonts.packages = [
      pkgs.nerd-fonts.jetbrains-mono
    ];

  #services.nix-daemon.enable = lib.mkForce true;

  system.stateVersion = 5;
}