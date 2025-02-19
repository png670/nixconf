
{ pkgs, lib, config, ... }: {

    options = {
        dwm.enable =
            lib.mkEnableOption "enables dwm";
    };

    config = lib.mkIf config.dwm.enable {
        home.packages = let
            dwm = pkgs.dwm.override {
                conf = ./config.def.h;
            };
        in with pkgs; [
            dwm
        ];
    };
}
