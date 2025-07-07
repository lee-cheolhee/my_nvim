require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "c", "cpp", "cmake", 
    "python", 
    "dockerfile", 
    "bash", "regex", 
    "json", "yaml",
    "lua"
  },
  highlight = {
    enable = true, -- Treesitter 하이라이트 활성화
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = { enable = true },
  indent = { enable = true },
}

vim.api.nvim_set_hl(0, "@type", { link = "Type" })
vim.api.nvim_set_hl(0, "@type.builtin", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@namespace", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@class", { link = "Structure" })
vim.api.nvim_set_hl(0, "@struct", { link = "Structure" })
vim.api.nvim_set_hl(0, "@interface", { link = "Structure" })
vim.api.nvim_set_hl(0, "@enum", { link = "Structure" })

-- nvim-autopairs 기본 설정
require("nvim-autopairs").setup {
  check_ts = true, -- Treesitter 통합
  disable_filetype = { "TelescopePrompt", "vim" },
}

-- nvim-cmp와 nvim-autopairs 연동
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')

-- -- Fold 설정
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- vim.opt.foldlevel = 99
--
-- -- Fold 키 매핑
-- vim.api.nvim_set_keymap('n', '<leader>zR', 'zR', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>zM', 'zM', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>za', 'za', { noremap = true, silent = true })
