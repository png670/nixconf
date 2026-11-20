{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.userSettings.yapfast;
  yapfast = inputs.yapfast.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
    # Upstream's source filter leaves out testing/, but testing/hosts became a
    # workspace member on 19 Nov, so cargo can't load the workspace without it.
    src = inputs.yapfast;
    patches = (old.patches or [ ]) ++ [ ./yapfast-libertinus-mono.patch ];
    postPatch = (old.postPatch or "") + ''
      cp ${pkgs.libertinus}/share/fonts/opentype/LibertinusMono-Regular.otf \
        crates/yapfast-iced-kit/fonts/
    '';
    # Upstream's package.nix still treats deep_filter as a git dependency;
    # it's been in vendor/ since 18 Nov.
    cargoDeps = pkgs.rustPlatform.importCargoLock {
      lockFile = "${inputs.yapfast}/Cargo.lock";
      outputHashes = {
        "const_panic-0.2.15" = "sha256-zEmo8lKncnNhn2LL5aRT95AZD/LqjmNcRg2qTKXLcic=";
        "matrix-rtc-bridge-0.4.0-rc.1" = "sha256-Zm+5xARhyrix22Ihz2fesWkwg21FaT/eqi240eT1lnQ=";
        "matrix-sdk-0.19.1" = "sha256-MzEIaDxJVssAiTd2r7qRSdkZvD+IYpC71shuJU5TATE=";
      };
    };
    # Only installed the DeepFilterNet model, which now ships in vendor/deep_filter.
    preBuild = "";
  });
in
{
  options.userSettings.yapfast.enable = lib.mkEnableOption "Yapfast with Libertinus Mono";

  config = lib.mkIf cfg.enable {
    home.packages = [ yapfast ];
  };
}
