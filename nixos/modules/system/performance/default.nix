{ ... }:

{

  services = {
    # thermald (prevent overheating)
    thermald.enable = true;
    auto-cpufreq.enable = true;

    # tlp (power saving)
    tlp.enable = false;  # enable this if you want,
  };
}
