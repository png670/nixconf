# Based on the actual install: a single USB drive (GPT) holding the pftf/RPi4
# UEFI firmware + Limine on a FAT32 ESP, and an ext4 root partition — see the
# install notes. Mounted by label rather than /dev/sdX or UUID since this is
# removable USB media and by-label survives it enumerating on a different
# port/order than it did during install.
{ lib, ... }:

{
  boot.initrd.availableKernelModules = [
    "usbhid"
    "usb_storage"
    "vc4"
    "pcie_brcmstb"
    "reset-raspberrypi"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/ESP";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  # zramSwap (systemSettings.performance) covers swap instead of a disk
  # partition — nothing to declare here.
  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
