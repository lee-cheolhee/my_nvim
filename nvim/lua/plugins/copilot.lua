require("copilot").setup({
  suggestion = { enabled = true },
  panel      = { enabled = true },
})

-- let g:copilot_no_tab_map = v:true
-- inoremap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
-- inoremap <silent><script><expr> <C-L> copilot#Next()
-- inoremap <silent><script><expr> <C-H> copilot#Previous()
-- nnoremap <silent> <C-P> :Copilot panel<CR>

require("CopilotChat").setup {
  -- See Configuration section for options
  keymaps = {
    submit = "<C-Enter>",  -- 메시지 전송 키맵
    scroll_up = "<C-k>",   -- 채팅 스크롤 업 키맵
    scroll_down = "<C-j>", -- 채팅 스크롤 다운 키맵
  },
  window = {
    -- layout = "left",    -- 채팅 창 위치 (left, right, top, bottom)
    width = 50,            -- 채팅 창 너비
  },
}
vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChatToggle<CR>", { desc = "Toggle Copilot Chat" })
