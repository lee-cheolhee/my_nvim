-- ~/.config/nvim/lua/theme/github.lua

require("github-theme").setup({
  comment_style = "italic",
  keyword_style = "bold",
  function_style = "bold",
  variable_style = "NONE",
  sidebars = { "qf", "help", "terminal", "NvimTree" },
  dark_sidebar = true,
  dark_float = true,

  -- 불투명 강조 및 비활성창 어둡게
  dim_inactive = true,

  overrides = function(c)
    return {
      Comment = { fg = c.fg_dark, italic = false },
      CursorLine = { bg = c.bg2 },
      CursorLineNr = { fg = c.orange, bold = true },
      LineNr = { fg = c.fg_dark },
      Visual = { bg = "#334155" },
      Search = { fg = c.bg, bg = c.orange, bold = true },
      IncSearch = { fg = c.bg, bg = c.yellow, bold = true },
      Pmenu = { bg = c.bg2, fg = c.fg },
      PmenuSel = { bg = c.bg3, fg = c.fg_bold, bold = true },
    }
  end,
})

