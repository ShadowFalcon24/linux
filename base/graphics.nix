{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.graphics.driver;
in {
  options.graphics.driver = {
    enableNvidia = lib.mkEnableOption "Enable NVIDIA drivers and related settings";
    enableAmd = lib.mkEnableOption "Enable AMD drivers with Vulkan and OpenCL support";
  };

  config = lib.mkMerge [
    #### AMD CONFIG ####
    (lib.mkIf cfg.enableAmd {
      # Xorg/Wayland Treiber für AMD
      services.xserver.videoDrivers = ["amdgpu"];

      # Aktiviert Mesa (OpenGL/Vulkan), 32-bit Support für Proton/Wine
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          amf # Advanced Media Framework (Video-Encoding)
          rocmPackages.clr.icd # OpenCL ICD (ROCm)
          amdvlk # Optionaler Vulkan-Treiber (neben RADV)
        ];
        extraPackages32 = with pkgs; [
          driversi686Linux.amdvlk
        ];
      };

      # HIP-Symlink für Software wie Blender, die /opt/rocm erwartet
      systemd.tmpfiles.rules = [
        "L+ /opt/rocm/hip - - - - ${pkgs.rocmPackages.clr}"
      ];

      # Diagnose-Tools für AMD
      environment.systemPackages = with pkgs; [
        clinfo # Test für OpenCL
        vulkan-tools # Test für Vulkan
        mesa-demos # OpenGL Test
      ];

      # Firmware für amdgpu (wichtig für RX 7000 / 9000)
      hardware.enableRedistributableFirmware = true;
    })

    #### NVIDIA CONFIG ####
    (lib.mkIf cfg.enableNvidia {
      services.xserver.videoDrivers = ["nvidia"];

      hardware.nvidia = {
        modesetting.enable = true;

        powerManagement.enable = false;
        powerManagement.finegrained = false;

        open = true; # NVIDIA Open Kernel Module (nur für neuere GPUs)
        nvidiaSettings = true;

        # Beta-Treiber für neueste Features
        package = config.boot.kernelPackages.nvidiaPackages.beta;
      };

      # Tools für NVIDIA
      environment.systemPackages = with pkgs; [
        nvidia-settings
      ];
    })

    #### MULTI-GPU-FALL ####
    (lib.mkIf (cfg.enableAmd && cfg.enableNvidia) {
      warnings = ["Beide GPUs aktiviert. Prüfe PRIME oder render offload, um Konflikte zu vermeiden."];
    })
  ];
}
