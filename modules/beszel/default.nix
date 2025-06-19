{ inputs, config, pkgs, lib, ... }:

let
  cfg = config.services.beszel-agent;

  # A helper to find the "primary user"
  primaryUser = builtins.head (lib.attrNames config.users.users or {});
in {
  options.services.beszel-agent = {
    enable = lib.mkEnableOption "Enable the beszel-agent user service for all users";

    key = lib.mkOption {
      type = lib.types.str;
      description = "The SSH public key used by beszel-agent and added to the authorized_keys of the primary user.";
      example = "ssh-ed25519 AAAAC3NzaC1lZDI1N...";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ beszel ];

    systemd.user.services.beszel-agent = {
      description = "Beszel Agent";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        ExecStart = ''
          ${pkgs.beszel}/bin/beszel-agent -key "${cfg.key}"
        '';
        Restart = "on-failure";
      };
    };

    # Inject the systemd service for all users
    users.users = lib.mapAttrs (_: userCfg: {
      systemd.user.services.beszel-agent = config.systemd.user.services.beszel-agent;
    }) config.users.users;

    # Ensure primary user has authorized_keys set
    users.users.${primaryUser}.openssh.authorizedKeys.keys = [
      cfg.key
    ];
  };
}
