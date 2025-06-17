{ config, pkgs, lib, inputs, ... }:
let
  onePassPath = "~/.1password/agent.sock";
in 
{
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ../../../dots/plasma/default.nix
    inputs.catppuccin.homeModules.catppuccin
    ../../../dots/catppuccin/default.nix
  ];

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ${onePassPath}
    '';
  };
}
