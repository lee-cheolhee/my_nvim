vim.cmd [[packadd alpha-nvim]]

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
    "                                                      ", 
    " ███████╗ █████╗ ██████╗ ███╗   ███╗██╗██╗  ██╗   ██╗ ",
    " ██╔════╝██╔══██╗██╔══██╗████╗ ████║██║██║  ╚██╗ ██╔╝ ",
    " █████╗  ███████║██████╔╝██╔████╔██║██║██║   ╚████╔╝  ",
    " ██╔══╝  ██╔══██║██╔══██╗██║╚██╔╝██║██║██║    ╚██╔╝   ",
    " ██║     ██║  ██║██║  ██║██║ ╚═╝ ██║██║███████╗██║    ",
    " ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚══════╝╚═╝    ",
    "                                                      ",
}

-- 메뉴 버튼 설정
dashboard.section.buttons.val = {
  dashboard.button("e", "📄 > 새 파일 열기", ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "🔎 > 파일 찾기", ":Telescope find_files <CR>"),
  dashboard.button("r", "🗂️ > 최근 파일", ":Telescope oldfiles <CR>"),
  dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua<CR>"),
  dashboard.button("q", "❌ > 종료", ":qa<CR>"),
}

local function footer()
 return "Welcome to FARMILY! 🦾 "
end

dashboard.section.footer.val = footer()
-- 색상 적용 (선택 사항)
-- dashboard.section.header.opts.hl = "Type"
-- dashboard.section.buttons.opts.hl = "Function"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"
dashboard.section.footer.opts.hl = "Type"
dashboard.opts.opts.noautocmd = true 
-- 시작 화면 설정 적용
alpha.setup(dashboard.opts)
-- alpha.setup(dashboard.config)

