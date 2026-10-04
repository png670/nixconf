{ ... }:

{
  boot.loader.limine = {
    enable = true;
    efiSupport = true;
    biosSupport = false;
    maxGenerations = 10;
  };

  # Only errors reach the console.
  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;

  # systemd-based initrd.
  boot.initrd.systemd.enable = true;

  # /tmp starts empty on every boot.
  boot.tmp.cleanOnBoot = true;
}
