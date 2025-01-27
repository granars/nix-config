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
      cleanup = "uninstall";
      upgrade = true;
    };
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
    ];
    masApps = {
      "CotEditor" = 1024640650;
    };
   };
    environment.systemPackages = with pkgs; [
      git
      git-crypt
      discord
      obsidian
      ollama
      inputs.agenix.packages."${system}".default
    ];

    fonts.packages = [
      pkgs.nerd-fonts.jetbrains-mono
    ];

  services.nix-daemon.enable = lib.mkForce true;

  system.stateVersion = 5;
}