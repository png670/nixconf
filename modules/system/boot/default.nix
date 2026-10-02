{ ... }:

{
  boot.loader.systemd-boot.enable = false;

  boot.loader.limine = {
    enable = true;
    efiSupport = true;
    biosSupport = false;
    maxGenerations = 10;
  };

  # only err-and-worse gets printed to the console.
  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;

  # tmpfiles clean up /tmp.
  boot.initrd.systemd.enable = true;
  boot.tmp.cleanOnBoot = true;
}
