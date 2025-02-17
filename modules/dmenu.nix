{ config, lib, pkgs, ... }:

{
  options = {
    programs.dmenu.enable = lib.mkEnableOption "dmenu launcher";
  };

  config = lib.mkIf config.programs.dmenu.enable {
    environment.systemPackages = with pkgs; [ dmenu ];
  };
}
