
{
  pkgs,
  config,
  ...
}: {
  programs.kitty = {
    enable = true;

    settings = {
      background = "#0b0806";
      foreground = "#a19782";
      selection_foreground = "#a19782";
      selection_background = "#373b41";

      cursor = "#844d2c";
      cursor_text_color = "#1d2021";

      url_color = "#b4b7b4";

      active_tab_foreground = "#a19782";
      active_tab_background = "#282a2e";
      inactive_tab_foreground = "#718062";
      inactive_tab_background = "#2f2b2a";

      active_border_color = "#526274";
      inactive_border_color = "#373b41";

      color0  = "#0b0806";
      color1  = "#844d2c";
      color2  = "#57553a";
      color3  = "#a17c38";
      color4  = "#41434f";
      color5  = "#6b4444";
      color6  = "#59664c";
      color7  = "#a19782";
      color8  = "#2f2b2a";
      color9  = "#a64848";
      color10 = "#897f5a";
      color11 = "#c8b38d";
      color12 = "#526274";
      color13 = "#755c47";
      color14 = "#718062";
      color15 = "#c1ab83";

      color16 = "#de935f";
      color17 = "#a3685a";
      color18 = "#282a2e";
      color19 = "#373b41";
      color20 = "#b4b7b4";
      color21 = "#e0e0e0";

      background_opacity = "0.9";

      font_family = "monospace";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = "10.0";

      confirm_os_window_close = "0";
      enable_audio_bell = "no";

      allow_remote_control = "yes";
      listen_on = "unix:/tmp/kitty";

      cursor_trail = "0";
    };

    extraConfig = ''
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
