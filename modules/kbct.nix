{ config, lib, pkgs, ... }:
with lib;

let
  description = "Keyboard keycode mapping utility for Linux supporting layered configuration";
  cfg = config.services.kbct;
  configFile = pkgs.writeText "kbct-remap.yml" ''
    ${cfg.config}
  '';
in
{
  options.services.kbct = {
    enable = mkEnableOption "kbct";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.kbct;
      inherit description;
    };

    config = mkOption {
      type = types.lines;
      default = "";
      description = "Inline kbct YAML remapping configuration.";
    };
  };

  # environment.etc."kbct-remap.yml".text = cfg.config;

  config = lib.mkIf cfg.enable {
    boot.kernelModules = [ "uinput" ];
    users.users.kbct = {
      isNormalUser = true;
      extraGroups = [ "input" ];
    };
    systemd.services.kbct = {
      inherit description;
      # after = 
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        ExecStart = "${cfg.package}/bin/kbct remap --config ${configFile}";
        # Restart = "always";
      };
    };
  };
}
