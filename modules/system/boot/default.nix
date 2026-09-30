{ pkgs, ... }:

{
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.limine = {
    enable = true;
    efiSupport = true;
    biosSupport = false;
    maxGenerations = 10;
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelModules = [ "i2c-dev" ];

  # Quieter boot: only err-and-worse gets printed to the console.
  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;

  # Modern boot path: systemd in stage 1, tmpfiles clean up /tmp.
  boot.initrd.systemd.enable = true;
  boot.tmp.cleanOnBoot = true;
}
