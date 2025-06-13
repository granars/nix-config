{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  home.packages = with pkgs; [ grc ];

  programs = {
    vscode = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
        ms-python.vscode-pylance
        bbenoist.nix
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-ssh-edit
        redhat.vscode-yaml
      ];
    };
  };
}
