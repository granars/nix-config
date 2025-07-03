{ inputs, lib, config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "nate";
    userEmail = "github@granars.cloud";
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH3FK9J6CrT8NPGx11kUigv7vSaSDikC/jo4nA+P8gWl";
      signByDefault = true;
    };
    extraConfig = {
      gpg = {
        format = "ssh";
      };
    };
  };
}