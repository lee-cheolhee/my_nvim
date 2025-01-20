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

"*************
" cpp plugin
"*************

"*************
" python plugin
"*************
Plug 'tell-k/vim-autopep8'
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}

"*************
" git plugin
"*************
Plug 'github/copilot.vim'
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

"*************
" ros plugin
"*************
Plug 'thibthib18/ros-nvim'

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
  highlight = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = true },
  fold = { enable = true },
}

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

-- Mason 설정 및 설치
mason.setup()
mason_lspconfig.setup {
  ensure_installed = {
    "pyright", "clangd", "dockerls", "jsonls", "html", "intelephense", "yamlls", "bashls",
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

-- LSP 서버 설정
local servers = {
  pyright = {},
  clangd = {
    cmd = { "clangd", "--compile-commands-dir=" .. vim.fn.expand("~/catkin_ws") },
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
        width = 30,          -- 탐색기 너비 설정
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
        width = 40,                        -- 창 너비
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
        -- section_separators = {'', ''},  -- 섹션 구분 기호
        -- component_separators = {'', ''}  -- 컴포넌트 구분 기호
        section_separators = '',  -- 섹션 구분 기호 비활성화
        component_separators = '' -- 컴포넌트 구분 기호 비활성화
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
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = false,
    term_colors = true,
    styles = {
        comments = { "italic" }, -- 주석에 italic 적용
        conditionals = { "italic" }, -- 조건문에 italic 적용
        loops = {}, -- 루프에는 italic 비활성화
        functions = { "italic" }, -- 함수에 italic + bold 적용
        keywords = { "italic" }, -- 키워드에 italic 적용
        strings = {}, -- 문자열에는 italic 비활성화
        variables = {}, -- 변수에 italic 비활성화
    },
})
EOF
" colorscheme
set termguicolors
colorscheme tokyodark

" 옵션 설정 (선택 사항)
let g:tokyonight_style = 'storm'       " 가능한 옵션: 'storm', 'night', 'day'
let g:tokyonight_enable_italic = 1     " 기울임꼴 활성화
let g:tokyonight_transparent = 1       " 배경 투명화

