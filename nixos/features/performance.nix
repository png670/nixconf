{ inputs, outputs, lib, config, pkgs, ... }:
{
  ## POWER
  powerManagement = {
    enable = false;
    #cpuFreqGovernor = "schedutil";
  };
  services.power-profiles-daemon.enable = false;
#  services.auto-cpufreq.enable = true;
#  services.auto-cpufreq.settings = {
#	  battery = {
#	     governor = "powersave";
#	     turbo = "never";
#	  };
#	  charger = {
#	     governor = "performance";
#	     turbo = "auto";
#	  };
#	};

  ### KERNEL
  boot.kernelParams = [
    "ahci.mobile_lpm_policy=3"
    "rtc_cmos.use_acpi_alarm=1"
  ];

  ### HWP
  systemd.tmpfiles.rules = [
    "w /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference - - - - balance_power"
  ];

  ### TLP
  services.tlp = {
      enable = true;
  };

  ### SYSTEM 76 SCHEDULER
  services.system76-scheduler.settings.cfsProfiles.enable = true;

  ### POWERTOP
  #powerManagement.powertop.enable = true;

  ### ThermalD
  services.thermald.enable = true;
}
