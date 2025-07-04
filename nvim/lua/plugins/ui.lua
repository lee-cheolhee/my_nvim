-- NvimTree
require("nvim-tree").setup {
    view = {
        width = 60,          -- 탐색기 너비 설정
        side = "right",       -- 탐색기 위치 (left, right)
    },
    filters = {
        dotfiles = true,     -- 숨김 파일 표시 여부
    },
    renderer = {
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
        },
    },
}
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true })

-- Aerial
require("aerial").setup {
    backends = { "lsp", "treesitter", "markdown" }, -- 백엔드 설정
    layout = {
        default_direction = "float", -- 창 위치 (right, left, float, prefer_right, prefer_left)
        width = 80,                        -- 창 너비
    },
    show_guides = true,                    -- 계층 구조 가이드라인 표시
    filter_kind = {                        -- 표시할 심볼 종류 필터링
        "Class",
        "Function",
        "Method",
        "Variable",
    },
}
vim.keymap.set("n", "<C-t>", ":AerialToggle<CR>", { silent = true })

-- Lualine
require('lualine').setup {
    options = {
        theme = 'papercolor_dark',
        theme = 'palenight',
        section_separators = {'', ''},  -- 섹션 구분 기호
        component_separators = {'', ''}  -- 컴포넌트 구분 기호
        -- section_separators = '',  -- 섹션 구분 기호 비활성화
        -- component_separators = '' -- 컴포넌트 구분 기호 비활성화
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {
            {
                'filename',
                path = 2
            }
                    },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
}

-- Bufferline
require('bufferline').setup {
    options = {
        numbers = "ordinal", -- 버퍼 번호를 정렬
        diagnostics = "nvim_lsp", -- LSP 진단 정보 표시
        show_buffer_close_icons = false, -- 버퍼 닫기 버튼 표시
        show_close_icon = true, -- 전체 닫기 버튼 비활성화
        separator_style = "slant", -- 버퍼 사이의 구분선 스타일
    }
}
vim.keymap.set("n", "<leader>z",  ":BufferLineCyclePrev<CR>",  { silent = true })
vim.keymap.set("n", "<leader>x",  ":BufferLineCycleNext<CR>",  { silent = true })
vim.keymap.set("n", "<leader>d",  ":bdelete<CR>",              { silent = true })
vim.keymap.set("n", "<leader>p",  ":BufferLinePick<CR>",       { silent = true })
vim.keymap.set("n", "<leader>pd", ":BufferLinePickClose<CR>",  { silent = true })

-- " 현재 버퍼를 왼쪽 창으로 옮기기
-- nnoremap <silent> <Leader>h :wincmd h \| b#<CR>
-- " 현재 버퍼를 아래 창으로 옮기기
-- nnoremap <Leader>j :wincmd j \| b#<CR>
-- " 현재 버퍼를 위 창으로 옮기기
-- nnoremap <Leader>k :wincmd k \| b#<CR>
-- " 현재 버퍼를 오른쪽 창으로 옮기기
-- nnoremap <Leader>l :wincmd l \| b#<CR>

-- Indent guides
require("ibl").setup {
    indent = {
        char = "│",  -- Indent 가이드 문자
    },
    scope = {
        enabled = true,  -- 컨텍스트 강조 활성화
        show_start = true,
        show_end = true,
    },
    exclude = {
        filetypes = { "help", "dashboard", "terminal" },  -- 제외할 파일 유형
    },
}

-- Gitsigns
require('gitsigns').setup {
    signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
    },
    current_line_blame = true, -- 현재 줄의 blame 표시
}

-- 하이라이트 설정
vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'DiffAdd' })
vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'DiffChange' })
vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'DiffDelete' })
vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { link = 'DiffDelete' })
vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { link = 'DiffChange' })

-- noice
require("noice").setup({
  cmdline = {
    enabled = true,
    view = "cmdline_popup",  -- 명령줄 UI 스타일 ("cmdline_popup"도 가능)
  },
  messages = {
    enabled = true,    -- Neovim의 메시지 UI 개선
    view = "mini", -- 메시지를 작은 팝업 창으로 표시
  },
  popupmenu = {
    enabled = true,    -- 명령어 자동 완성 UI 활성화
  },
  lsp = {
    signature = {
      enabled = false,
    },
  },
})

-- Comment
require('Comment').setup {
    mappings = {
        basic = true,    -- 기본 키 매핑 사용
        extra = true,    -- 추가 키 매핑 사용
    },
}

-- notify
local colors = require("catppuccin.palettes").get_palette("mocha")
local bg = vim.api.nvim_get_hl_by_name("Normal", true).background

require("notify").setup({
--   background_colour = "#1e1e2e", -- Catppuccin Mocha 테마와 어울리는 어두운 색
  -- background_colour = colors.base,
  background_colour = string.format("#%06x", bg or 0x000000)
})

require("noice").setup({
  cmdline = {
    enabled = true,
    view = "cmdline_popup",  -- 명령줄 UI 스타일 ("cmdline_popup"도 가능)
  },
  messages = {
    enabled = true,    -- Neovim의 메시지 UI 개선
    view = "mini", -- 메시지를 작은 팝업 창으로 표시
  },
  popupmenu = {
    enabled = true,    -- 명령어 자동 완성 UI 활성화
  },
  lsp = {
    signature = {
      enabled = false,
    },
  },
})

require("edgy").setup({
  bottom = {
    { ft = "toggleterm", size = 15 },
    { ft = "qf", title = "QuickFix" },
  },
  right = {
    { ft = "aerial", title = "Outline" },
  },
})

require("twilight").setup()
require("zen-mode").setup {
  window = {
    width = 80,
    options = {
      number = false,
      relativenumber = false,
    },
  },
}
