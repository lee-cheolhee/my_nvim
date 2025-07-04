local mason = require("mason")
local mlsp = require("mason-lspconfig")
local lspconfig = require("lspconfig")

mason.setup()
mlsp.setup {
  ensure_installed = { "clangd", "pyright", "bashls", "jsonls", "yamlls" },
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

local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
  root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
})

-- 나머지 서버는 default
for _, server in ipairs({ "pyright", "bashls", "jsonls", "yamlls" }) do
  lspconfig[server].setup { on_attach = on_attach, capabilities = capabilities }
end
