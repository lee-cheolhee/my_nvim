-- require("nvim-treesitter.configs").setup({
--   ensure_installed = {
--     "c", "cpp", "python", "bash", "json", "yaml",
--     "dockerfile", "cmake", "lua"
--   },
--   highlight = { enable = true },
--   indent     = { enable = true },
--   incremental_selection = { enable = true },
-- })
--
-- vim.opt.foldmethod, vim.opt.foldexpr, vim.opt.foldlevel = "expr",
--   "nvim_treesitter#foldexpr()", 99

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
  fold = { enable = true },
}

vim.api.nvim_set_hl(0, "@type", { link = "Type" })
vim.api.nvim_set_hl(0, "@type.builtin", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@namespace", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@class", { link = "Structure" })
vim.api.nvim_set_hl(0, "@struct", { link = "Structure" })
vim.api.nvim_set_hl(0, "@interface", { link = "Structure" })
vim.api.nvim_set_hl(0, "@enum", { link = "Structure" })

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

-- Mason 설정 및 설치
mason.setup()
mason_lspconfig.setup {
  ensure_installed = {
    "pyright", "dockerls", "jsonls", "html", "intelephense", "yamlls", "bashls",
  }
}

-- 공통 LSP 설정
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gf', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<Cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }
-- LSP 서버 설정
local servers = {
  pyright = {},
  clangd = {
    capabilities = capabilities,
    cmd = { "clangd",
            "--background-index",
            "--all-scopes-completion",
            "--clang-tidy",
            "--header-insertion-decorators",
            "--suggest-missing-includes",
            "--completion-style=detailed",
            "--pch-storage=memory",
            "--limit-results=30",
            "--j=6",
            "--log=error",
            "--header-insertion=never",
            "--clang-tidy-checks=-*,modernize-deprecated-headers,llvm-include-order,readability-*",
            "--compile-commands-dir=" .. vim.fn.expand("/home/rdv/farmily_ws/build") },
    root_dir = require('lspconfig/util').root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
  },

  dockerls = {},
  jsonls = {},
  html = {},
  intelephense = {},
  yamlls = {},
  bashls = {},
}

for server, config in pairs(servers) do
  config.on_attach = on_attach
  lspconfig[server].setup(config)
end

-- nvim-autopairs 기본 설정
require("nvim-autopairs").setup {
  check_ts = true, -- Treesitter 통합
  disable_filetype = { "TelescopePrompt", "vim" },
}

-- nvim-cmp와 nvim-autopairs 연동
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')

-- Fold 설정
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99

-- Fold 키 매핑
vim.api.nvim_set_keymap('n', '<leader>zR', 'zR', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>zM', 'zM', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>za', 'za', { noremap = true, silent = true })
