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
    ../../../modules/homemanager/beszel
  ];

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ${onePassPath}
    '';
  
  programs.beszel-agent = {
    enable = true;
    key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE+Y6wfEc7+Qh0ZAJ6Bzkzl+I+WEUMn1kFQDfMKg5n3Q";
  };
  
  };
}
