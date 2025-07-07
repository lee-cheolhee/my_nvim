local mason = require("mason")
local mlsp = require("mason-lspconfig")
local lspconfig = require("lspconfig")

mason.setup()
mlsp.setup {
  ensure_installed = { 
        "clangd", "pyright", "dockerls", "jsonls", "yamlls", "bashls",
    },
}

-- 공통 on_attach
local function on_attach(_, bufnr)
  vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    severity_sort = true,
  }, bufnr)
end

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

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.offsetEncoding = { "utf-16" }

lspconfig.clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--header-insertion=never",
    "--completion-style=detailed",
    "--pch-storage=memory",
    "--j=6",
    "--log=error",
    "--limit-results=30",
    "--compile-commands-dir=" .. vim.fn.expand("~/farmily_ws/build"),
  },
  -- cmd = {
  --   "clangd",
  --   "--background-index",
  --   "--all-scopes-completion",
  --   "--clang-tidy",
  --   "--header-insertion-decorators",
  --   "--suggest-missing-includes",
  --   "--completion-style=detailed",
  --   "--pch-storage=memory",
  --   "--limit-results=30",
  --   "--j=6",
  --   "--log=error",
  --   "--header-insertion=never",
  --   "--clang-tidy-checks=-*,modernize-deprecated-headers,llvm-include-order,readability-*",
  --   "--compile-commands-dir=" .. vim.fn.expand("/home/rdv/farmily_ws/build") 
  -- },
  root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
})

-- 나머지 서버는 default
for _, server in ipairs({ "pyright", "bashls", "jsonls", "yamlls" }) do
  lspconfig[server].setup { on_attach = on_attach, capabilities = capabilities }
end
