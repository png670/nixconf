{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  cfg = config.userSettings.serein;

  font = "${pkgs.libertinus}/share/fonts/opentype/LibertinusMono-Regular.otf";

  serein = inputs.serein.packages.${pkgs.stdenv.hostPlatform.system}.serein.overrideAttrs (old: {
    # Blood-red dark palette + Libertinus Mono for code blocks too.
    patches = (old.patches or [ ]) ++ [ ./serein-blood.patch ];

    # Inter is baked in with include_bytes!, so swapping the files swaps the UI font.
    postPatch = (old.postPatch or "") + ''
      for face in Inter-Regular Inter-Medium Inter-SemiBold; do
        cp --no-preserve=mode ${font} assets/fonts/$face.ttf
      done
    '';
  });
in
{
  options.userSettings.serein.enable = lib.mkEnableOption "Patched Serein";

  config = lib.mkIf cfg.enable {
    home.packages = [ serein ];
  };
}
