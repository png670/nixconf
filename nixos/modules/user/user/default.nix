{ pkgs, lib, user, ... }:

{
  programs.zsh.enable = true;
  # Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;

    users.${user} = {
      isNormalUser = true;
      description = "${user}";
      extraGroups = [ "wheel" ];
      packages = with pkgs; [];
    };
  };
}
