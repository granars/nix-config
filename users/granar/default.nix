{
  config,
  inputs,
  pkgs,
  ...
}:
{
  nix.settings.trusted-users = [ "granar" ];

#  age.secrets.hashedUserPassword = {
#    file = "${inputs.secrets}/hashedUserPassword.age";
#  };

  users = {
    users = {
      granar = {
        shell = pkgs.zsh;
        uid = 1000;
        isNormalUser = true;
#        hashedPasswordFile = config.age.secrets.hashedUserPassword.path;
        extraGroups = [
          "wheel"
          "users"
          "input"
        ];
        group = "granar";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEA/C1HbyHK/AkmHBRQQTRGB7jN/4syG1OR8lDD7brPv admin@granars.cloud"
        ];
      };
    };
    groups = {
      granar = {
        gid = 1000;
      };
    };
  };
  programs.zsh.enable = true;

}

