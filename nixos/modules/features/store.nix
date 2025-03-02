{
  # auto-gc every week
  nix = {
    optimise.automatic = true;
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
