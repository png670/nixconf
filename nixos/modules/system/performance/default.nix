{ ... }:

{
  services = {
    # thermald (prevent overheating)
    thermald.enable = true;

    # tlp (power saving)
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC  = "performance"  ;
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave"    ;
        CPU_ENERGY_PERF_POLICY_ON_AC  = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "powersave"  ;

        # save long term battery health
        START_CHARGE_THRESH_BAT0 = 70; # start charging at 40 and below
        STOP_CHARGE_THRESH_BAT0  = 90; # stop charging at 95 and above
      };
    };
  };
}
