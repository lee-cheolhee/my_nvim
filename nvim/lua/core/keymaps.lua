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


-- 경고 표시
map("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostics under cursor" })
-- 🔍 진단 전체 보기: Telescope diagnostics
map("n", "<leader>gl", "<cmd>Telescope diagnostics<CR>", {
  desc = "Show all diagnostics via Telescope",
  silent = true,
})


-- buffer 
vim.keymap.set("n", "<leader>z",  ":BufferLineCyclePrev<CR>",  { silent = true })
vim.keymap.set("n", "<leader>x",  ":BufferLineCycleNext<CR>",  { silent = true })
vim.keymap.set("n", "<leader>d",  ":bdelete<CR>",              { silent = true })
vim.keymap.set("n", "<leader>p",  ":BufferLinePick<CR>",       { silent = true })
vim.keymap.set("n", "<leader>pd", ":BufferLinePickClose<CR>",  { silent = true })

-- " 현재 버퍼를 왼쪽 창으로 옮기기
vim.keymap.set("n", "<Leader>h", ":wincmd h | b#<CR>", { silent = true })
-- " 현재 버퍼를 아래 창으로 옮기기
vim.keymap.set("n", "<Leader>j", ":wincmd j | b#<CR>", { silent = true })
-- " 현재 버퍼를 위 창으로 옮기기
vim.keymap.set("n", "<Leader>k", ":wincmd k | b#<CR>", { silent = true })
-- " 현재 버퍼를 오른쪽 창으로 옮기기
vim.keymap.set("n", "<Leader>l", ":wincmd l | b#<CR>", { silent = true })
