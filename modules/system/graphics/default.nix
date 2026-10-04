{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.systemSettings.graphics;
in
{
  options.systemSettings.graphics.enable = lib.mkEnableOption "NVIDIA graphics";

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true; 
      extraPackages = [ pkgs.nvidia-vaapi-driver ]; 
    };

    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      powerManagement.enable = true;
    };

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      NVD_BACKEND = "direct";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };
}
