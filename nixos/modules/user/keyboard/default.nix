{
  services.xserver.xkb = { # kblayout
    layout = "gb";
    variant = "";
  };
  console = {
    keyMap = "uk";
    useXkbConfig = true;
    earlySetup = true;  # for grub?
  };
}
