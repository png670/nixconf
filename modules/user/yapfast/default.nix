{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.userSettings.yapfast;
  yapfast = inputs.yapfast.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [ ./yapfast-libertinus-mono.patch ];
    postPatch = (old.postPatch or "") + ''
      cp ${pkgs.libertinus}/share/fonts/opentype/LibertinusMono-Regular.otf \
        crates/yapfast-iced-kit/fonts/
    '';
  });
in
{
  options.userSettings.yapfast.enable = lib.mkEnableOption "Yapfast with Libertinus Mono";

  config = lib.mkIf cfg.enable {
    home.packages = [ yapfast ];
  };
}
