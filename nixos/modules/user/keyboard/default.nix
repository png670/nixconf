{
  services.xserver.xkb = { # kblayout
    layout = "gb";
    variant = "";
  };
  console = {
    useXkbConfig = true;
    earlySetup = true;  # for grub?
  };
}
