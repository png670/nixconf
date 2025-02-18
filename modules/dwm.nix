
{ config, pkgs, ... }:

let
  # Define terminal, browser, and editor as variables
  terminal = "kitty";
  browser = "firefox";
  editor = "nvim";
in

{
  # Enable dwm and apply custom configuration
  services.xserver.windowManager.dwm = {
    enable = true;
    config = {
      borderpx = 2;
      snap = 14;
      gappih = 10;
      gappiv = 10;
      gappoh = 10;
      gappov = 10;
      swallowfloating = 0;
      smartgaps = 0;
      showbar = 1;
      topbar = 1;
      user_bh = 18;
      showtab = "showtab_auto"; # Use appropriate value
      tags = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" ];
      layouts = [
        { symbol = "[]="; arrange = "tile"; }
        { symbol = "TTT"; arrange = "bstack"; }
        { symbol = "[M]"; arrange = "monocle"; }
        { symbol = "[D]"; arrange = "deck"; }
        { symbol = "###"; arrange = "nrowgrid"; }
        { symbol = "><>"; arrange = null; }
        { symbol = "[\\]"; arrange = "dwindle"; }
        { symbol = "[@]"; arrange = "spiral"; }
        { symbol = "|M|"; arrange = "centeredmaster"; }
        { symbol = ">M>"; arrange = "centeredfloatingmaster"; }
      ];

      rules = [
        { class = "Gimp"; instance = null; title = null; tags = 0; isfloating = 0; isterminal = 0; noswallow = 0; monitor = 0; }
        { class = browser; instance = null; title = null; tags = 0; isfloating = 0; isterminal = 0; noswallow = 0; monitor = 0; }
        { class = terminal; instance = null; title = null; tags = 0; isfloating = 0; isterminal = 1; noswallow = 0; monitor = 0; }
        # Add more rules as needed based on your config
      ];

      # Define scratchpads
      scratchpads = [
        { name = "spnvim"; cmd = [ terminal "-n" "spnvim" "-g" "90x40" "-e" "nvim" ]; }
        { name = "spcmus"; cmd = [ terminal "-n" "spcmus" "-g" "110x35" "-e" "cmus" ]; }
        { name = "spterm"; cmd = [ terminal "-n" "spterm" "-g" "135x35" ]; }
        { name = "spfloaterm"; cmd = [ terminal "-n" "spfloaterm" "-g" "85x34" ]; }
        { name = "spcalc"; cmd = [ terminal "-n" "spcalc" "-g" "75x30" "-e" "bc" "-ql" ]; }
        { name = "sptrans-ga"; cmd = [ terminal "-n" "sptrans-ga" "-T" "Trans-Ga" "-g" "90x30" "-e" "trans" ":ga" "-I" ]; }
        { name = "sptrans-de"; cmd = [ terminal "-n" "sptrans-de" "-T" "Trans-De" "-g" "90x30" "-e" "trans" ":de" "-I" ]; }
        { name = "sptrans-en"; cmd = [ terminal "-n" "sptrans-en" "-T" "Trans-En" "-g" "90x30" "-e" "trans" ":en" "-I" ]; }
      ];

      # Additional keybindings can be added here
      keybindings = {
        "mod4 + Return" = "${terminal}";
        "mod4 + q" = "killclient";
        "mod4 + b" = "${browser}";
        "mod4 + d" = "dmenu_run";
        # Add other keybindings from your config
      };
    };
  };
}
