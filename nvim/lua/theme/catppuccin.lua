require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha 중 선택 가능
    transparent_background = true, -- 배경 투명 여부
    term_colors = true, -- 터미널 컬러 지원 활성화

    styles = {
        comments = { "italic" }, -- 주석을 italic 스타일로
        conditionals = { "bold" }, -- if, else 같은 조건문을 bold 처리
        loops = { "bold" }, -- for, while 같은 반복문을 bold 처리
        functions = { "bold", "italic" }, -- 함수명을 bold + italic 적용
        keywords = { "bold" }, -- return, break 같은 키워드 강조
        strings = { "italic" }, -- 문자열을 italic 스타일 적용
        variables = { "bold" }, -- 변수명을 bold 처리
        numbers = { "bold", "underline" }, -- 숫자를 bold + 밑줄 처리하여 강조
        types = { "bold", "italic" }, -- 타입(예: int, float 등)도 강조
    },

    integrations = {
        treesitter = true,
        native_lsp = {
            enabled = true,
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
        },
        gitsigns = true, -- Git 변경 사항 강조
        telescope = true, -- Telescope UI 색상 적용
        nvimtree = true, -- NvimTree(파일 탐색기) 색상 적용
        cmp = true, -- nvim-cmp 자동완성 강조
        lsp_saga = true, -- LSP UI 색상 적용
        markdown = true, -- Markdown 강조
        dashboard = true, -- Alpha.nvim 같은 대시보드 스타일링 적용
        indent_blankline = {
            enabled = true,
            colored_indent_levels = true, -- 코드 들여쓰기 색상 추가
        },
    },
    -- custom_highlights = function(colors)
    -- return {
    --   ["@type"] = { fg = colors.blue },       -- 기본 타입 (int, float)
    --   ["@type.builtin"] = { fg = colors.red }, -- 내장 타입 (void, size_t)
    --   ["@class"] = { fg = colors.teal },       -- 클래스 이름
    --   ["@struct"] = { fg = colors.green },     -- 구조체
    -- }
    -- end
})

-- vim.cmd("colorscheme catppuccin")
