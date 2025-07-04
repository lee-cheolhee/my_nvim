-- Step 1. 기본 설정
require("core.options")
require("core.keymaps")
require("core.autocommands")

-- Step 2. 플러그인 설치
require("plugins")

-- Step 3. mason이 설치됐는지 확인 후 나머지 플러그인 설정 실행
vim.schedule(function()
  -- mason 폴더가 존재할 때만 나머지 로드
  local mason_path = vim.fn.stdpath("data") .. "/site/pack/plugins/start/mason.nvim"
  if vim.fn.isdirectory(mason_path) ~= 0 then
    require("plugins.alpha")
    require("plugins.cmp")
    require("plugins.copilot")
    require("plugins.dap")
    -- require("plugins.flutter")
    require("plugins.lsp")
    require("plugins.telescope")
    require("plugins.treesitter")
    require("plugins.ui")

    require("theme.catppuccin")
    -- 유틸
    require("utils.build_tools")
    require("utils.rsync")
  else
    print("⚠️ mason.nvim 아직 설치되지 않았습니다. Neovim 재시작 후 다시 시도하세요.")
  end
end)
