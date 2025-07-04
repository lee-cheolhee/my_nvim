-- ~/.config/nvim/lua/utils/terminal.lua

local M = {}

function M.run_in_popup_terminal(cmd)
  local buf = vim.api.nvim_create_buf(false, false)
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.6)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = row,
    col = col,
    width = width,
    height = height,
    border = "rounded",
    style = "minimal"
  })

  vim.fn.termopen(cmd)
  vim.cmd("startinsert")

  vim.keymap.set("t", "<Esc>", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, { buffer = buf, silent = true })
end

return M
