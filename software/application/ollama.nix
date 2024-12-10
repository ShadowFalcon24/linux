{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.software.application.ollama;
in {
  options.software.application.ollama = {
    enable = lib.mkEnableOption "enable ollama on this machine";
    gpuAccelerationType = lib.mkOption {
      default = "rocm";
      description = "The GPU acceleration to use for ollama";
    };
  };

  config = lib.mkIf cfg.enable {
    services.ollama = {
      enable = true;
      acceleration = cfg.gpuAccelerationType;
    };
  };
}
