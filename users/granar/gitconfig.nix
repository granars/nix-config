{ inputs, lib, config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "nate";
    userEmail = "github@granars.cloud";
  };
}