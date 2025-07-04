require("copilot").setup({
  suggestion = { enabled = true },
  panel      = { enabled = true },
})
-- Copilot: TAB 키 기본 매핑 제거
vim.g.copilot_no_tab_map = true

-- Copilot 인라인 수락
vim.keymap.set("i", "<C-j>", 'copilot#Accept("<CR>")', {
  expr = true,
  silent = true,
  script = true,
  desc = "Copilot Accept Suggestion",
})

-- Copilot 다음 제안으로 이동
vim.keymap.set("i", "<C-l>", 'copilot#Next()', {
  expr = true,
  silent = true,
  script = true,
  desc = "Copilot Next Suggestion",
})

-- Copilot 이전 제안으로 이동
vim.keymap.set("i", "<C-h>", 'copilot#Previous()', {
  expr = true,
  silent = true,
  script = true,
  desc = "Copilot Previous Suggestion",
})

-- Copilot 패널 열기 (노멀 모드)
vim.keymap.set("n", "<C-p>", ":Copilot panel<CR>", {
  silent = true,
  desc = "Open Copilot Panel",
})

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
