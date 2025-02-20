
{ config, ... }:

{
  services.xserver.enable = true;
  services.xserver.windowManager.dwm.enable = true;

  # change to your preference

  services.displayManager.ly.enable = true;
  services.picom.enable = true;
}
