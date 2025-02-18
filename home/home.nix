
{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "png76";
  home.homeDirectory = "/home/png76";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # You can add packages here if needed.
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # You can manage your dotfiles here if needed.
  };

  windowManager.dwm = {
    enable = true;
    package = pkgs.dwm.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "png670";  # Corrected to the proper GitHub user
        repo = "dwm";
        rev = "main";  # Use "main" instead of "master"
        sha256 = "sha256-BS0TqbPZwDoh/qx2MgTnpM3rFcRC2R4e0/TssFPuTxA=";  # Ensure this hash is correct
      };
    });
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";  # Uncomment and set your preferred editor if needed
  };

  ## Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
