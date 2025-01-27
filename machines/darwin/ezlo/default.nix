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
    ];
    masApps = {
      "CotEditor" = 1024640650;
    };
   };
    environment.systemPackages = with pkgs; [
      zoxide
      fzf
      discord
      obsidian
      whatsapp-for-mac
      rpi-imager
      inputs.agenix.packages."${system}".default
    ];

    fonts.packages = [
      (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      # New pkgs.nerd-fonts.jetbrains-mono
    ];

  services.nix-daemon.enable = lib.mkForce true;

  system.stateVersion = 5;
}