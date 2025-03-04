
{
  pkgs,
  config,
  ...
}: {
  programs.kitty = {
    enable = true;

    shellIntegration.enableZshIntegration = true;

    settings = {

    # colors
      background = "#13141d";
      foreground = "#cfd1dd";
      cursor = "#c4c8c5";
      selection_background = "#d8bf80";

      color0 = "#000000";
      color8 = "#80a1bd";
      color1 = "#cc6666";
      color9 = "#cc6666";
      color2 = "#b5bd68";
      color10 = "#b5bd68";
      color3 = "#f0c574";
      color11 = "#f0c574";
      color4 = "#80a1bd";
      color12 = "#80a1bd";
      color5 = "#b294ba";
      color13 = "#b294ba";
      color6 = "#8abdb6";
      color14 = "#8abdb6";
      color7 = "#fffefe";
      color15 = "#fffefe";

      selection_foreground = "#1d1f21";

      #fonts
      font_family = "monospace";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = "10.0";

      confirm_os_window_close = "0";
      enable_audio_bell = "no";

      cursor_text_color = "background";

      allow_remote_control = "yes";
      listen_on = "unix:/tmp/kitty";
      shell_integration = "enabled";

      cursor_trail = "0";
    };

    extraConfig = ''
      # GENERATED
      action_alias kitty_scrollback_nvim kitten /home/${config.home.username}/.local/share/nvim/lazy/kitty-scrollback.nvim/python/kitty_scrollback_nvim.py
      map kitty_mod+h kitty_scrollback_nvim
      map kitty_mod+g kitty_scrollback_nvim --config ksb_builtin_last_cmd_output
      map ctrl+equal     change_font_size all +2.0
      map ctrl+minus     change_font_size all -2.0
      map ctrl+backspace change_font_size all 0
      mouse_map ctrl+shift+right press ungrabbed combine : mouse_select_command_output : kitty_scrollback_nvim --config ksb_builtin_last_visited_cmd_output
    '';
  };
}
