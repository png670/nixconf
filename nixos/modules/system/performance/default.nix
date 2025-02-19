{ ... }:

{
  services = {
    # thermald (prevent overheating)
    thermald.enable = true;

    # tlp (power saving)
    tlp.enable = true;
  };
}
