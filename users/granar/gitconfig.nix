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
        signingKey = "...";
      };
    };
  };
}