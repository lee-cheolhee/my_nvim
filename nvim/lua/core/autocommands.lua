vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.keymap.set("n", "<F8>", ":call Autopep8()<CR>", { buffer = true })
  end,
})
