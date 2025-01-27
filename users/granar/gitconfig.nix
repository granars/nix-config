{ inputs, lib, config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "granars";
    userEmail = "github@granars.cloud";
  };
}