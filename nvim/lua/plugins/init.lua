--[[
 📦 plugins/init.lua
 Neovim의 플러그인들을 직접 git clone하여 설치하고 로드하는 최소한의 패키지 매니저 없이 사용하는 방식.
--]]

-- 플러그인을 설치할 디렉토리 경로 (site/pack/plugins/start/)
local install_path = vim.fn.stdpath("data") .. "/site/pack/plugins/start/"

-- 사용하고자 하는 GitHub 플러그인 리스트
local plugins = {
  -- ☆ 종속성 / Utility
  { repo = "nvim-lua/plenary.nvim" },
  { repo = "MunifTanjim/nui.nvim", name = "nui.nvim" }, -- noice.nvim 의 필수 종속성

  -- ☆ 테마 & UI
  { repo = "catppuccin/nvim", name = "catppuccin" },
  { repo = "folke/tokyonight.nvim" },
  { repo = "projekt0n/github-nvim-theme", name = 'github-theme' },

  { repo = "folke/which-key.nvim" },
  { repo = "folke/zen-mode.nvim" },
  { repo = "folke/twilight.nvim" },
  { repo = "folke/edgy.nvim" },
  { repo = "folke/noice.nvim" },
  { repo = "rcarriga/nvim-notify" },
  { repo = "goolord/alpha-nvim" },
  { repo = "nvim-tree/nvim-web-devicons" },
  { repo = "nvim-tree/nvim-tree.lua" },
  { repo = "akinsho/bufferline.nvim", name = "bufferline.nvim" },
  { repo = "nvim-lualine/lualine.nvim" },
  { repo = "stevearc/aerial.nvim" },

  -- ☆ 탐색 기능
  { repo = "nvim-telescope/telescope.nvim" },

  -- ☆ 코드 하이라이트 및 구조
  { repo = "nvim-treesitter/nvim-treesitter" },
  { repo = "kevinhwang91/nvim-ufo" },
  { repo = "kevinhwang91/promise-async" }, -- 의존성
  { repo = "L3MON4D3/LuaSnip" },

  -- ☆ LSP / 자동완성
  { repo = "neovim/nvim-lspconfig" },
  { repo = "williamboman/mason.nvim" },
  { repo = "williamboman/mason-lspconfig.nvim" },
  { repo = "hrsh7th/nvim-cmp" },
  { repo = "hrsh7th/cmp-nvim-lsp" },
  { repo = "L3MON4D3/LuaSnip" },
  { repo = "saadparwaiz1/cmp_luasnip" },
  { repo = "windwp/nvim-autopairs" },
  { repo = "nvimtools/none-ls.nvim" },

  -- ☆ Git / AI
  { repo = "lewis6991/gitsigns.nvim" },
  { repo = "zbirenbaum/copilot.lua" },
  { repo = "CopilotC-Nvim/CopilotChat.nvim" },

  -- ☆ DAP (Debug Adapter Protocol)
  { repo = "mfussenegger/nvim-dap" },

  -- ☆ 기타
  { repo = "lukas-reineke/indent-blankline.nvim" },
  { repo = "numToStr/Comment.nvim" },
}

-- 플러그인마다 존재 여부 확인 후 git clone
for _, plugin in ipairs(plugins) do
  -- repo 이름에서 마지막 부분을 디렉토리 이름으로 사용
  local name = plugin.name or plugin.repo:match(".*/(.*)")
  local path = install_path .. name

  -- 경로가 존재하지 않으면 git clone
  if vim.fn.empty(vim.fn.glob(path)) > 0 then
    print("🔌 Installing " .. plugin.repo)
    vim.fn.system({
      "git", "clone", "--depth", "1",
      "https://github.com/" .. plugin.repo,
      path
    })
  end
end

vim.defer_fn(function()
  if vim.fn.argc() == 0 and vim.fn.expand("%") == "" then
    vim.cmd("Alpha")
  end
end, 50)

----------------------------------------------------------------------
-- 1) 모든 플러그인 git pull / clone  -------------------------------
----------------------------------------------------------------------
local function update_plugins()
  -- ① 업데이트용 bash 스크립트 한 덩어리 만들기
  local lines = { "set -e" }
  for _, plugin in ipairs(plugins) do
    local name = plugin.name or plugin.repo:match(".*/(.*)")
    local path = install_path .. name
    table.insert(lines, string.format([[
      if [ -d "%s" ]; then
        echo "🔄  updating %s ..."
        git -C "%s" pull --ff-only
      else
        echo "🌱  cloning  %s ..."
        git clone --depth 1 https://github.com/%s "%s"
      fi
      ]], path, name, path, name, plugin.repo, path))
  end
  table.insert(lines, 'echo "✅  all plugins up-to-date!"')

  -- ② bash -c "여러 줄 스크립트" 형태로 실행
  local bash_script = table.concat(lines, "\n")
  require("utils.terminal").run_in_popup_terminal(
    { "bash", "-c", bash_script }
  )
-- vim.notify("✅ 플러그인 업데이트 완료!", vim.log.levels.INFO)
end


----------------------------------------------------------------------
-- 2) 명령어 & 키맵 & 알파 버튼 --------------------------------------
----------------------------------------------------------------------
-- :PlugUpdate 명령
vim.api.nvim_create_user_command("PlugUpdate", function()
  update_plugins()
end, { desc = "Git pull all custom-managed plugins" })
