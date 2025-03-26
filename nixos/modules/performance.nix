
{
  ## POWER
  powerManagement.enable = true;

  ### KERNEL
  boot.kernelParams = [
    "intel_pstate=active"
    "ahci.mobile_lpm_policy=3"
    "rtc_cmos.use_acpi_alarm=1"
  ];

  ### TLP
  services.tlp.enable = true;

  ### ThermalD (Prevents overheating)
  services.thermald.enable = true;

  services.system76-scheduler.enable = false;
  powerManagement.powertop.enable = false;
}
