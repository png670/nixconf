
{
  pkgs,
  config,
  ...
}: {
  programs.kitty = {
    enable = true;

    settings = {
      background = "#191724";
      foreground = "#e0def4";
      selection_foreground = "#e0def4";
      selection_background = "#403d52";

      cursor = "#524f67";
      cursor_text_color = "#e0def4";

      url_color = "#c4a7e7";

      active_tab_foreground = "#e0def4";
      active_tab_background = "#26233a";
      inactive_tab_foreground = "#6e6a86";
      inactive_tab_background = "#191724";

      active_border_color = "#31748f";
      inactive_border_color = "#403d52";

      color0  = "#26233a";
      color1  = "#eb6f92";
      color2  = "#31748f";
      color3  = "#f6c177";
      color4  = "#9ccfd8";
      color5  = "#c4a7e7";
      color6  = "#c4a7e7";
      color7  = "#e0def4";
      color8  = "#6e6a86";
      color9  = "#eb6f92";
      color10 = "#31748f";
      color11 = "#f6c177";
      color12 = "#9ccfd8";
      color13 = "#c4a7e7";
      color14 = "#c4a7e7";
      color15 = "#e0def4";

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
