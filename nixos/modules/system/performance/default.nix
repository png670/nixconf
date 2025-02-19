{ ... }:

{
  powerManagement.cpuFreqGovernor = "performance";

  services = {
    # thermald (prevent overheating)
    thermald.enable = true;

    # tlp (power saving)
    tlp.enable = false;  # enable this if you want,
  };
}
