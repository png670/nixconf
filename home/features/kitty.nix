
{
  pkgs,
  config,
  ...
}: {
  programs.kitty = {
    enable = true;

    shellIntegration.enableZshIntegration = true;

    settings = {

      background = "#191724";
      foreground = "#e0def4";
      cursor = "#e0def4";
      selection_background = "#ebbcba";
      selection_foreground = "#1f1d2e";

      color0  = "#191724";
      color1  = "#1f1d2e";
      color2  = "#26233a";
      color3  = "#6e6a86";
      color4  = "#908caa";
      color5  = "#e0def4";
      color6  = "#e0def4";
      color7  = "#524f67";
      color8  = "#eb6f92";
      color9  = "#f6c177";
      color10 = "#ebbcba";
      color11 = "#31748f";
      color12 = "#9ccfd8";
      color13 = "#c4a7e7";
      color14 = "#f6c177";
      color15 = "#524f67";

      background_opacity = "0.9";

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
