local map = vim.keymap.set
vim.g.mapleader = ","

-- 일반
map("n", "<leader>h", ":nohlsearch<CR>", { silent = true })
map("n", "<leader>tn", ":set nonumber norelativenumber<CR>")
map("n", "<leader>tnr", ":set number relativenumber<CR>")
map("n", "<leader>u", ":redo<CR>", { silent = true })

-- 클립보드
map({ "n", "v" }, "<leader>y", '"+y', { silent = true })
map("n", "<leader>p", '"+p', { silent = true })
map("n", "<leader>y", ':echo @"<CR>', { silent = true })
