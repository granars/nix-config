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

  imports = [ ./work.nix ];

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
      "element"
      "raycast"
      "zen-browser"
    ];
    masApps = {
      "CotEditor" = 1024640650;
    };
   };
    environment.systemPackages = with pkgs; [
      alacritty
      inputs.agenix.packages."${system}".default
    ];

    fonts.packages = [
        pkgs.nerd-fonts.jetbrains-mono
    ];

  services.nix-daemon.enable = lib.mkForce true;

  system.stateVersion = 5;
}