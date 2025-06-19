{ inputs, config, lib, pkgs, ... }:

let
  cfg = config.programs.beszel-agent;
in
{
  options.programs.beszel-agent = {
    enable = lib.mkEnableOption "Enable the beszel-agent user service";

    key = lib.mkOption {
      type = lib.types.str;
      description = "SSH public key to pass to beszel-agent and install in authorized_keys.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.beszel ];

    programs.ssh = {
      enable = true;
      authorizedKeys.keys = [ cfg.key ];
    };

    systemd.user.services.beszel-agent = {
      Enable = true;
      WantedBy = [ "default.target" ];
      Unit = {
        Description = "Beszel Agent";
        After = [ "network.target" ];
      };
      Service = {
        ExecStart = "${pkgs.beszel}/bin/beszel-agent -key '${cfg.key}'";
        Restart = "on-failure";
      };
    };
  };
}
