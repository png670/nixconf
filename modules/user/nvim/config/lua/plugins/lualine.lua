local function terminal_theme()
  local section = { fg = 'NONE', bg = 'NONE' }
  local mode = { a = { fg = 'NONE', bg = 'NONE', gui = 'bold' }, b = section, c = section }

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

-- Re-run if you ever do switch on termguicolors + a colorscheme later.
vim.api.nvim_create_autocmd('ColorScheme', { callback = setup })
