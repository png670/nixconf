-- Lualine themed off whatever colorscheme is actually active, instead of a
-- hardcoded palette: background stays "NONE" (shows the terminal's own
-- background straight through) and foreground is read live from the
-- Normal highlight group, so it always matches your terminal/colorscheme
-- and keeps matching if either changes.

local function hl_fg(name)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  if ok and hl.fg then
    return string.format('#%06x', hl.fg)
  end
  return nil
end

local function terminal_theme()
  local fg = hl_fg('Normal') or '#c1c2c3'
  local section = { fg = fg, bg = 'NONE' }
  local mode = { a = { fg = fg, bg = 'NONE', gui = 'bold' }, b = section, c = section }

  return {
    normal = mode,
    insert = mode,
    visual = mode,
    replace = mode,
    command = mode,
    inactive = mode,
  }
end

local function setup()
  require('lualine').setup({
    options = {
      theme = terminal_theme(),
      component_separators = '',
      section_separators = '',
      globalstatus = true,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { { 'filename', path = 1 } },
      lualine_x = { 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
  })
end

setup()

-- Re-derive colors whenever the colorscheme changes, so lualine never
-- freezes on whatever was active when Neovim started.
vim.api.nvim_create_autocmd('ColorScheme', { callback = setup })
