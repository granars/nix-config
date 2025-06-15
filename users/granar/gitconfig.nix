{ inputs, lib, config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "nate";
    userEmail = "github@granars.cloud";
    extraConfig = {
      gpg = {
        format = "ssh";
      };
      "gpg \"ssh\"" = {
        program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      };
      commit = {
        gpgsign = true;
      };

      user = {
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH3FK9J6CrT8NPGx11kUigv7vSaSDikC/jo4nA+P8gWl";
      };
    };
  };
}