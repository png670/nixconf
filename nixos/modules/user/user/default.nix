
{ pkgs, lib, user, ... }:

{
  programs.zsh.enable = true;

  users.users.png76 = {
    isNormalUser = true;
    description = "png76";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;  # Set default shell for the user
  };
}
