{ inputs, config, lib, pkgs, ... }:

let
  cfg = config.services.beszel-agent;
in
{
  options.services.beszel-agent = {
    enable = lib.mkEnableOption "Enable the beszel-agent system service";

    key = lib.mkOption {
      type = lib.types.str;
      description = "SSH public key to pass to beszel-agent on launch.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.beszel ];

    systemd.services.beszel-agent = {
      description = "Beszel Agent System Service";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.beszel}/bin/beszel-agent -key '${cfg.key}'";
        Restart = "on-failure";
        User = "root";  # or another system user if needed
      };
    };
  };
}