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

local function move_buf_to_split(dir)
  local bufnr = vim.api.nvim_get_current_buf()
  local cur_win = vim.api.nvim_get_current_win()

  -- 시도: 해당 방향으로 이동
  vim.cmd("wincmd " .. dir)
  local moved_win = vim.api.nvim_get_current_win()

  -- 이동 실패했으면 split 강제 생성 + 이동
  if moved_win == cur_win then
    if dir == "h" then
      vim.cmd("leftabove vsplit")
    elseif dir == "l" then
      vim.cmd("rightbelow vsplit")
    elseif dir == "j" then
      vim.cmd("belowright split")
    elseif dir == "k" then
      vim.cmd("aboveleft split")
    end
    vim.cmd("wincmd " .. dir)  -- 생성 후 다시 이동
    moved_win = vim.api.nvim_get_current_win()
  end

  -- 현재 창에 버퍼를 띄우고
  vim.cmd("buffer " .. bufnr)
  vim.fn.win_gotoid(cur_win)
  local altbuf = vim.fn.bufnr('#')  -- "이전" 버퍼
  if altbuf == -1 or altbuf == bufnr then
    vim.cmd('enew')                -- 대체 버퍼 없으면 빈 버퍼
  else
    vim.cmd('buffer ' .. altbuf)   -- 다른 버퍼 보여주기
  end

end
-- 키맵 등록
vim.keymap.set("n", "<leader>h", function() move_buf_to_split("h") end, { desc = "Move buffer left", silent = true })
vim.keymap.set("n", "<leader>j", function() move_buf_to_split("j") end, { desc = "Move buffer down", silent = true })
vim.keymap.set("n", "<leader>k", function() move_buf_to_split("k") end, { desc = "Move buffer up", silent = true })
vim.keymap.set("n", "<leader>l", function() move_buf_to_split("l") end, { desc = "Move buffer right", silent = true })

-- ✅ Ctrl + Space → Linewise toggle
vim.keymap.set("n", "<leader>/", require("Comment.api").toggle.linewise.current, { desc = "Toggle line comment" })
vim.keymap.set("v", "<leader>/", function()
  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  vim.api.nvim_feedkeys(esc, "x", false)
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = "Visual toggle line comment" })

-- ✅ Alt + / → Blockwise toggle
vim.keymap.set("n", "<M-/>", require("Comment.api").toggle.blockwise.current, { desc = "Toggle block comment" })
vim.keymap.set("v", "<M-/>", function()
  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  vim.api.nvim_feedkeys(esc, "x", false)
  require("Comment.api").toggle.blockwise(vim.fn.visualmode())
end, { desc = "Visual toggle block comment" })

vim.keymap.del("n", "gc")
vim.keymap.del("v", "gc")
vim.keymap.del("o", "gc")
