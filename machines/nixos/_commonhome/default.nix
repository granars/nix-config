{ inputs, lib, config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = { 
        name = "nate";
        email = "github@granars.cloud";
      };
      aliases = {
        ci = "commit";
        co = "checkout";
        s = "status";
      };
      gpg.format = "ssh";
    };
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH3FK9J6CrT8NPGx11kUigv7vSaSDikC/jo4nA+P8gWl";
      signByDefault = true;
    };
  };
}