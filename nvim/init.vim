"***************************************************************************** 
" Plug install packages
"*****************************************************************************
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
call plug#begin(expand('~/.config/nvim/plugged'))
 
"*************
" theme.
"************
Plug 'folke/tokyonight.nvim', { 'branch' : 'main' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'tiagovla/tokyodark.nvim', { 'branch': 'master' }

Plug 'MunifTanjim/nui.nvim'   " noice.nvim의 필수 종속성
Plug 'rcarriga/nvim-notify'   " 더 나은 메시지 UI
Plug 'folke/noice.nvim'       " 개선된 명령줄 UI

Plug 'goolord/alpha-nvim'  " Neovim 시작 화면 플러그인
Plug 'nvim-lua/plenary.nvim'  " 필수 종속성
Plug 'nvim-tree/nvim-web-devicons' " 아이콘 지원 (선택 사항)

"*************
" etc.
"************
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons' " 파일 아이콘 표시를 위해 필요 (선택 사항)
Plug 'stevearc/aerial.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim', {'tag': '*', 'do': ':TSUpdate'}
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'hrsh7th/nvim-cmp'               " 자동 완성 플러그인
Plug 'hrsh7th/cmp-nvim-lsp'           " LSP 소스 연결
Plug 'windwp/nvim-autopairs'          " 자동 괄호 닫기 플러그인
Plug 'nvimtools/none-ls.nvim'

"*************
" Programming Language
"*************
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/async.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'          " LSP 서버 설치 관리
Plug 'williamboman/mason-lspconfig.nvim' " Mason과 lspconfig 통합

" 검색 및 탐색 도구
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'             " Telescope 의존성

" Debug
Plug 'mfussenegger/nvim-dap'
" Plug 'theHamsta/nvim-dap-virtual-text'
"Plug 'rcarriga/nvim-dap-ui'

"*************
" cpp plugin
"*************

"*************
" python plugin
"*************
" Plug 'tell-k/vim-autopep8'
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}

"*************
" git plugin
"*************
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
Plug 'github/copilot.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim'

"*************
" ros plugin
"*************
Plug 'thibthib18/ros-nvim'

"*************
" flutter plugin
"*************
Plug 'akinsho/flutter-tools.nvim'

call plug#end()
" 
" Required:
filetype plugin indent on

"*****************************************************************************
" Basic Setup
"*****************************************************************************"
" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Fix backspace indent
set backspace=indent,eol,start

" Tabs. May be overridden by autocmd rule
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set cindent

" Map leader to ,
let mapleader=','

" Enable hidden buffers
set hidden

" Searching
set hlsearch
nnoremap <silent> <leader>h :nohlsearch<CR>
set incsearch
set ignorecase
set smartcase
nnoremap <silent> <leader>r :redo<CR>
set fileformats=unix,dos,mac
 
"*****************************************************************************
" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number
set relativenumber
nnoremap <leader>tn :set nonumber norelativenumber<CR>
nnoremap <leader>tnr :set number relativenumber<CR>

" Better command line completion 
set wildmenu

set mouse=
set clipboard+=unnamed,unnamedplus
vnoremap <silent> <leader>y "+y
nnoremap <silent> <leader>p "+p

nnoremap <silent> <leader>y :echo @"<CR>

" vim-autopep8
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>
let g:autopep8_ignore="E501,W293"

" copilot keymap
let g:copilot_no_tab_map = v:true
inoremap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
inoremap <silent><script><expr> <C-L> copilot#Next()
inoremap <silent><script><expr> <C-H> copilot#Previous()
nnoremap <silent> <C-P> :Copilot panel<CR>

" nvim-treesitter config
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "cpp", "python", "bash", "c", "json", "dockerfile", "yaml", "cuda", "xml", "cmake", "regex" },
  highlight = {
    enable = true, -- Treesitter 하이라이트 활성화
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = { enable = true },
  indent = { enable = true },
  fold = { enable = true },
}

vim.api.nvim_set_hl(0, "@type", { link = "Type" })
vim.api.nvim_set_hl(0, "@type.builtin", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@namespace", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@class", { link = "Structure" })
vim.api.nvim_set_hl(0, "@struct", { link = "Structure" })
vim.api.nvim_set_hl(0, "@interface", { link = "Structure" })
vim.api.nvim_set_hl(0, "@enum", { link = "Structure" })

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

-- Mason 설정 및 설치
mason.setup()
mason_lspconfig.setup {
  ensure_installed = {
    "pyright", "dockerls", "jsonls", "html", "intelephense", "yamlls", "bashls",
  }
}

-- 공통 LSP 설정
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gf', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<Cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }
-- LSP 서버 설정
local servers = {
  pyright = {},
  clangd = {
    capabilities = capabilities,
    cmd = { "clangd",
            "--background-index",
            "--all-scopes-completion",
            "--clang-tidy",
            "--header-insertion-decorators",
            "--suggest-missing-includes",
            "--completion-style=detailed",
            "--pch-storage=memory",
            "--limit-results=30",
            "--j=6",
            "--log=error",
            "--header-insertion=never",
            "--clang-tidy-checks=-*,modernize-deprecated-headers,llvm-include-order,readability-*",
            "--compile-commands-dir=" .. vim.fn.expand("/home/rdv/farmily_ws/build") },
    root_dir = require('lspconfig/util').root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
  },

  dockerls = {},
  jsonls = {},
  html = {},
  intelephense = {},
  yamlls = {},
  bashls = {},
}

for server, config in pairs(servers) do
  config.on_attach = on_attach
  lspconfig[server].setup(config)
end

-- nvim-autopairs 기본 설정
require("nvim-autopairs").setup {
  check_ts = true, -- Treesitter 통합
  disable_filetype = { "TelescopePrompt", "vim" },
}

-- nvim-cmp와 nvim-autopairs 연동
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  },
})

-- Fold 설정
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99

-- Fold 키 매핑
vim.api.nvim_set_keymap('n', '<leader>zR', 'zR', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>zM', 'zM', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>za', 'za', { noremap = true, silent = true })
EOF

lua << EOF
local telescope = require('telescope')

telescope.setup {
    defaults = {
        file_ignore_patterns = { "node_modules", ".git", "build", "devel", "install" }, -- 무시할 파일 및 디렉터리
        mappings = {
            i = {
                ["<C-n>"] = require('telescope.actions').move_selection_next,
                ["<C-p>"] = require('telescope.actions').move_selection_previous,
            },
        },
    },
}

-- Telescope 명령어에 키맵 연결
vim.api.nvim_set_keymap('n', '<leader>ff', '<Cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<Cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', '<Cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', '<Cmd>Telescope help_tags<CR>', { noremap = true, silent = true })

-- Fuction for selecting buffers and performing vimdiff
function DiffBuffers()
    require('telescope.builtin').buffers {
        attach_mappings = function(_, map)
            local actions = require('telescope.actions')
            local state = require('telescope.actions.state')

            local buffer_seclection = {}

            map('i', '<CR>', function(prompt_bufnr)
                local selection = state.get_selected_entry()
                table.insert(buffer_seclection, selection.bufnr)

                if #buffer_seclection == 2 then
                    actions.close(prompt_bufnr)
                    vim.cmd('vsplit')
                    vim.cmd('buffer ' .. buffer_seclection[1])
                    vim.cmd('diffthis')
                    vim.cmd('wincmd w')
                    vim.cmd('buffer ' .. buffer_seclection[2])
                    vim.cmd('diffthis')
                else
                    actions.move_selection_next(prompt_bufnr)
                end
            end)
            return true
        end
    }
    end

    vim.api.nvim_set_keymap('n', '<leader>fd', ':lua DiffBuffers()<CR>', { noremap = true, silent = true })
EOF

" nvim-tree 설정
lua << EOF
require("nvim-tree").setup {
    view = {
        width = 60,          -- 탐색기 너비 설정
        side = "left",       -- 탐색기 위치 (left, right)
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
EOF

lua << EOF
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
EOF

nnoremap <silent> <C-n> :NvimTreeToggle<CR>
nnoremap <silent> <C-t> :AerialToggle<CR>

lua << EOF
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
EOF

lua << EOF
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
EOF

lua << EOF
require('Comment').setup {
    mappings = {
        basic = true,    -- 기본 키 매핑 사용
        extra = true,    -- 추가 키 매핑 사용
    },
}
EOF

lua << EOF
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
EOF

lua << EOF
require('bufferline').setup {
    options = {
        numbers = "ordinal", -- 버퍼 번호를 정렬
        diagnostics = "nvim_lsp", -- LSP 진단 정보 표시
        show_buffer_close_icons = false, -- 버퍼 닫기 버튼 표시
        show_close_icon = true, -- 전체 닫기 버튼 비활성화
        separator_style = "slant", -- 버퍼 사이의 구분선 스타일
    }
}
EOF

map <silent> <leader>z :BufferLineCyclePrev<CR>
map <silent> <leader>x :BufferLineCycleNext<CR>
map <silent> <leader>d :bdelete<CR>
map <silent> <leader>p :BufferLinePick<CR>
map <silent> <leader>pd :BufferLinePickClose<CR>

" 현재 버퍼를 왼쪽 창으로 옮기기
nnoremap <silent> <Leader>h :wincmd h \| b#<CR>
" 현재 버퍼를 아래 창으로 옮기기
nnoremap <Leader>j :wincmd j \| b#<CR>
" 현재 버퍼를 위 창으로 옮기기
nnoremap <Leader>k :wincmd k \| b#<CR>
" 현재 버퍼를 오른쪽 창으로 옮기기
nnoremap <Leader>l :wincmd l \| b#<CR>

lua << EOF
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

vim.cmd("colorscheme catppuccin-mocha")
EOF
" colorscheme
" set termguicolors
" colorscheme catppuccin-mocha

" 옵션 설정 (선택 사항)
" let g:tokyonight_style = 'storm'       " 가능한 옵션: 'storm', 'night', 'day'
" let g:tokyonight_enable_italic = 1     " 기울임꼴 활성화
" let g:tokyonight_transparent = 1       " 배경 투명화

lua << EOF
-- require("notify").setup({
--   background_colour = "#1e1e2e", -- Catppuccin Mocha 테마와 어울리는 어두운 색
-- })
local colors = require("catppuccin.palettes").get_palette("mocha")

require("notify").setup({
  background_colour = colors.base,
})
EOF

lua << EOF
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
EOF

lua << EOF
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
    "              Welcome to FARMILY! 🦾                  ",
}

-- 메뉴 버튼 설정
dashboard.section.buttons.val = {
  dashboard.button("e", "📄 > 새 파일 열기", ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "🔎 > 파일 찾기", ":Telescope find_files <CR>"),
  dashboard.button("r", "🗂️ > 최근 파일", ":Telescope oldfiles <CR>"),
  dashboard.button("q", "❌ > 종료", ":qa<CR>"),
}

-- 색상 적용 (선택 사항)
dashboard.section.header.opts.hl = "Type"
dashboard.section.buttons.opts.hl = "Function"

-- 시작 화면 설정 적용
alpha.setup(dashboard.config)

-- **올바른 대시보드 표시 설정**
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- 파일 없이 실행한 경우에만 대시보드 열기
    if vim.fn.argc() == 0 then
      require("alpha").start(true)
    end
  end,
})
EOF

"*****************************************************************************
" DAP(Debug Adapter Protocol)
" *****************************************************************************
lua << EOF
  local dap = require('dap')
  -- C++/clangd 디버깅을 위한 설정 예시
  dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = '/usr/bin/lldb',  -- 설치한 디버거의 경로로 수정
  }

  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "cppdbg",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopAtEntry = true,
    },
  }
  -- nvim-dap-ui 설정
  -- require("dapui").setup()
EOF
" 단축키 매핑 예시: F5로 디버깅 시작/재개, F10으로 한 단계 넘기기
nnoremap <F5> :lua require'dap'.continue()<CR>
nnoremap <F10> :lua require'dap'.step_over()<CR>
nnoremap <F11> :lua require'dap'.step_into()<CR>
nnoremap <F12> :lua require'dap'.step_out()<CR>

" 줄번호와 상대 줄번호 토글 함수
function! ToggleLineNumbers()
  if &number
    set nonumber norelativenumber
  else
    set number relativenumber
  endif
endfunction

" <leader> + s + n 키로 토글
nnoremap <leader>sn :call ToggleLineNumbers()<CR>

" flutter-tools.nvim 기본 설정 (더 많은 옵션은 공식 문서를 참고)
lua << EOF
require("flutter-tools").setup {
  -- flutter path, flutter sdk 경로가 PATH에 있으면 생략 가능
  flutter_path = "flutter",
  fvm = false, -- fvm 사용 시 true로 변경
  widget_guides = {
    enabled = true,
  },
  closing_tags = {
    highlight = "Error",
    prefix = ">> ",
  },
  debugger = {
    enabled = true,
    run_via_dap = true,
  }
}
EOF

"*****************************************************************************
" rsync
" *****************************************************************************
" exclude file
let g:rsync_exclude = [
    \ ".git",
    \ ".DS_Store",
    \ ".idea",
    \ ".vscode",
    \ 'build/',
    \ 'devel/',
    \ 'install/',
    \ 'log/',
    \ '*.log',
    \ 'cache/'
    \]

" 리스트를 --exclude 옵션 문자열로 변환
function! RsyncExclude()
  let l:exclude_str = ''
  for item in g:rsync_exclude
    let l:exclude_str .= ' --exclude="' . item . '"'
  endfor
  return l:exclude_str
endfunction

" 로컬 → 원격으로 동기화
command! RsyncUp execute '!rsync -avz --progress' . RsyncExclude() . ' /home/rdv/catkin_ws/src/ rdv@host:/home/rdv/path/'
" command! RsyncUp execute '!rsync -avz -e "ssh -i ~/.ssh/id_rsa" --progress' . RsyncExclude() . ' ./ user@host:/path/to/remote/'
" 원격 → 로컬로 동기화
command! RsyncDown execute '!rsync -avz --progress' . RsyncExclude() . ' rdv@host:/home/rdv/path/ /home/rdv/catkin_ws/src/'
" command! RsyncDown execute '!rsync -avz -e "ssh -i ~/.ssh/id_rsa" --progress' . RsyncExclude() . ' user@host:/path/to/remote/ ./'

nnoremap <leader>ru :echo "Rsync UP? (y/n)" \| call ConfirmRsync('up')<CR>
nnoremap <leader>rd :echo "Rsync DOWN? (y/n)" \| call ConfirmRsync('down')<CR>

function! ConfirmRsync(direction)
  let choice = input("Proceed with rsync " . a:direction . "? (y/n): ")
  if choice == 'y'
    if a:direction == 'up'
      execute ':RsyncUp'
    else
      execute ':RsyncDown'
    endif
  else
    echo "Rsync canceled"
  endif
endfunction

"*****************************************************************************
" Copilot Chat
" *****************************************************************************
lua << EOF
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
 vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChatToggle<CR>", { desc = "Toggle Copilot Chat" })
}
EOF

lua << EOF
local bg = vim.api.nvim_get_hl_by_name("Normal", true).background
require("notify").setup({
  background_colour = string.format("#%06x", bg or 0x000000)
})
EOF

lua << EOF
vim.on_key(function(char)
  if vim.fn.mode() == "n" then
    local code = vim.fn.char2nr(char)
    if code >= 44032 and code <= 55203 then
      return ""  -- 반드시 빈 문자열 반환
    end
  end
end, vim.api.nvim_create_namespace("ignore_hangul_in_normal"))
EOF
