""***************************************************************************** 
"" Plug install packages
""*****************************************************************************
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
call plug#begin(expand('~/.config/nvim/plugged'))

"*************
" theme.
"************
" Plug 'folke/tokyonight.nvim', { 'branch' : 'main' }
" "Plug 'maxmx03/fluoromachine.nvim'
" Plug 'EdenEast/nightfox.nvim'
" Plug 'shaunsingh/nord.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

"*************
" etc.
"************
Plug 'vim-scripts/DoxygenToolkit.vim'
"Plug 'preservim/tagbar'
"Plug 'preservim/nerdtree'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'Yggdroot/indentLine'
"Plug 'spf13/vim-autoclose'
"Plug 'preservim/nerdcommenter'

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
" " If use coc.nvim"
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
"
" If use vim-lsp
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/async.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'          " LSP 서버 설치 관리
Plug 'williamboman/mason-lspconfig.nvim' " Mason과 lspconfig 통합

" " 디버깅 플러그인
" Plug 'mfussenegger/nvim-dap'             " 디버깅 메인 플러그인
" Plug 'rcarriga/nvim-dap-ui'              " 디버깅 UI 플러그인
" Plug 'theHamsta/nvim-dap-virtual-text'   " 디버깅 가상 텍스트

" 검색 및 탐색 도구
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'             " Telescope 의존성

"*************
" cpp plugin
"*************
" Plug 'octol/vim-cpp-enhanced-highlight'

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
" Plug 'airblade/vim-gitgutter'
" Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'lewis6991/gitsigns.nvim'

"*************
" ros plugin
"*************
Plug 'thibthib18/ros-nvim'

call plug#end()

" Required:
filetype plugin indent on

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overridden by autocmd rule
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set cindent

"" Map leader to ,
let mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
nnoremap <silent> <leader>h :nohlsearch<CR>
set incsearch
set ignorecase
set smartcase
nnoremap <silent> <leader>r :redo<CR>
set fileformats=unix,dos,mac
 
"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number
set relativenumber
nnoremap <leader>tn :set nonumber norelativenumber<CR>
nnoremap <leader>tnr :set number relativenumber<CR>


"" Normal 모드에서 cursorline 활성화
"autocmd InsertLeave * set cursorline
"" Insert 모드에서 cursorline 비활성화
"autocmd InsertEnter * set nocursorline

" Better command line completion 
set wildmenu

" terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>
tnoremap <Esc> <C-\><C-n>

set mouse=
set clipboard+=unnamed,unnamedplus
"set clipboard+=unnamedplus
" "" Copy/Paste/Cut
" if has('unnamedplus')
  " set clipboard=unnamed,unnamedplus
" endif
vnoremap <silent> <leader>y "+y
nnoremap <silent> <leader>p "+p

nnoremap <silent> <leader>y :echo @"<CR>

" " buffer switching
" map <silent> <leader>z :bprev<CR>
" map <silent> <leader>x :bnext<CR>
" map <silent> <leader>d :bdelete<CR>

" " colorscheme
" let no_buffers_menu=1
" set termguicolors
" colorscheme carbonfox
" set background=dark

"" vim-airline theme
"let g:airline_theme='alduin'
"" vim-airline
"let g:airline#extensions#tabline#enabled = 1              " vim-airline ë²í¼ ëª©ë¡ ì¼ê¸°
"let g:airline#extensions#tabline#fnamemod = ':t'          " vim-airline ë²í¼ ëª©ë¡ íì¼ëªë§ ì¶ë ¥
"let g:airline#extensions#tabline#buffer_nr_show = 1       " buffer numberë¥¼ ë³´ì¬ì¤ë¤
"let g:airline#extensions#tabline#buffer_nr_format = '%s:' " buffer number format

" DoxygenToolkit
let g:DoxygenToolkit_briefTag_pre="@Synopsis  "
let g:DoxygenToolkit_paramTag_pre="@Param "
let g:DoxygenToolkit_returnTag="@Returns   "
let g:DoxygenToolkit_blockHeader="-------------------------------"
let g:DoxygenToolkit_blockFooter="---------------------------------"
let g:DoxygenToolkit_authorName="Mathias Lorente"
let g:DoxygenToolkit_licenseTag="My own license"

" old version"
"" NerdTree
"nnoremap <C-n> :NERDTreeToggle<CR>
"
"" Tagbar
"nnoremap <C-t> :TagbarToggle<CR>

" " cpp-enhanced-highlight
" let g:cpp_class_scope_highlight = 1
" let g:cpp_member_variable_highlight = 1
" let g:cpp_class_decl_highlight = 1
" let g:cpp_posix_standard = 1
" let g:cpp_experimental_template_highlight = 1
" let g:cpp_concepts_highlight = 1
" let g:cpp_no_function_highlight = 1

" " vim-lsp (using clangd)
" nnoremap <leader>d :LspDefinition<CR>
" nnoremap <leader>c :LspDeclaration<CR>
" nnoremap <leader>r :LspReferences<CR>

" " linux for clangd-10 
" " sudo apt install clangd-10
" if executable('clangd-10')
        " augroup lsp_clangd
                " autocmd!
                " autocmd User lsp_setup call lsp#register_server({
                                        " \ 'name': 'clangd',
                                        " \ 'cmd': {server_info->['clangd-10']},
                                        " \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                                        " \ })
        " augroup end
" endif

" " python ($ pip install python-language-server)
" if executable('pyls')
        " augroup lsp_clangd
            " autocmd User lsp_setup call lsp#register_server({ 
                                         " \ 'name': 'pyls',
					" \ 'cmd': {server_info->['pyls']},
					" \ 'whitelist': ['python'],
					" \ })
	" augroup end
" endif
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

"" indent guide
"let g:indent_guides_enable_on_vim_startup = 0
"" indent line
"let g:indentLine_enabled = 1
"""let g:indentLine_setColors = 0

" vim-autopep8
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>
let g:autopep8_ignore="E501,W293"

"" vim-nerdcommenter
"let g:NERDSpaceDelims = 1
"let g:NERDCompactSexyComs = 1
"" learder + c + c: commnet toggle
"vnoremap <leader>cc :call NERDComment(0, 'toggle')<CR>
"

" " nord theme
" let g:nord_contrast = v:true
" let g:nord_borders = v:false
" let g:nord_disable_background = v:false
" let g:nord_italic = v:false
" let g:nord_uniform_diff_background = v:true
" let g:nord_bold = v:false

"copilot keymap"
let g:copilot_no_tab_map = v:true
inoremap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
inoremap <silent><script><expr> <C-L> copilot#Next()
inoremap <silent><script><expr> <C-H> copilot#Previous()
nnoremap <silent> <C-P> :Copilot panel<CR>

" " Coc nvim. keymap
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gr <Plug>(coc-references)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" error check"
" nmap <silent> <learder>e :CocDiagonostic<CR>
" " CocCommand editor.action.formatDocument"
" nmap <silent> <learder>f :CocCommand<CR>

" nvim-treesitter config
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "cpp", "python", "bash", "c", "json", "dockerfile", "yaml", "cuda", "xml", "cmake", "regex" },
  highlight = {
    enable = true,
  },
}

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

-- Mason 설정 및 설치
mason.setup()
mason_lspconfig.setup {
    ensure_installed = {
        "pyright",       -- Python
        "clangd",        -- C, C++
        "dockerls",      -- Docker
        "jsonls",        -- JSON
        "html",          -- HTML
        "phpactor",      -- PHP
        "yamlls",        -- YAML
        "bashls",        -- Bash
    }
}

-- 공통 설정
local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gf', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<Cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
end

-- 서버별 설정
local servers = {
    pyright = {},                -- Python
    clangd = {},                 -- C, C++
    dockerls = {},               -- Docker
    jsonls = {},                 -- JSON
    html = {},                   -- HTML
    phpactor = {},               -- PHP
    yamlls = {},                 -- YAML
    bashls = {},                 -- Bash
}

for server, config in pairs(servers) do
    config.on_attach = on_attach
    lspconfig[server].setup(config)
end

require('lspconfig').clangd.setup {
    cmd = { "clangd", "--compile-commands-dir=~/catkin_ws" },
    root_dir = require('lspconfig/util').root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
    on_attach = on_attach,
}
EOF

" local dap = require('dap')
" local dapui = require('dapui')

" -- 디버깅 UI 설정
" dapui.setup()

" -- 디버깅 시작/종료 시 UI 동기화
" dap.listeners.after.event_initialized["dapui_config"] = function()
    " dapui.open()
" end
" dap.listeners.before.event_terminated["dapui_config"] = function()
    " dapui.close()
" end
" dap.listeners.before.event_exited["dapui_config"] = function()
    " dapui.close()
" end

" -- Python 디버깅 설정 (예제)
" dap.adapters.python = {
    " type = 'executable',
    " command = '/usr/bin/python3',
    " args = { '-m', 'debugpy.adapter' },
" }
" dap.configurations.python = {
    " {
        " type = 'python',
        " request = 'launch',
        " name = 'Launch file',
        " program = "${file}",
    " },
" }
"
nnoremap <silent> <C-n> :NvimTreeToggle<CR>
nnoremap <silent> <C-t> :AerialToggle<CR>
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
        default_direction = "prefer_right", -- 창 위치 (right, left)
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
-- nvim-autopairs 기본 설정
require("nvim-autopairs").setup {
    check_ts = true, -- Treesitter 통합
    disable_filetype = { "TelescopePrompt", "vim" }, -- 제외할 파일 유형
}

-- nvim-cmp와 nvim-autopairs 연동
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
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
require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = false,
    term_colors = true,
    styles = {
        comments = { "italic" }, -- 주석에 italic 적용
        conditionals = { "italic" }, -- 조건문에 italic 적용
        loops = {}, -- 루프에는 italic 비활성화
        functions = { "italic", "bold" }, -- 함수에 italic + bold 적용
        keywords = { "italic" }, -- 키워드에 italic 적용
        strings = {}, -- 문자열에는 italic 비활성화
        variables = {}, -- 변수에 italic 비활성화
    },
})
vim.cmd.colorscheme "catppuccin"
EOF

lua << EOF
local vim_utils = require "ros-nvim.vim-utils"
require 'ros-nvim'.setup {
  -- path to your catkin workspace
  catkin_ws_path = "~/catkin_ws",

  -- make program (e.g. "catkin_make" or "catkin build" )
  catkin_program = "catkin build",

  -- method for opening terminal for e.g. catkin_make: utils.open_new_buffer or custom function
  open_terminal_method = function()
      vim_utils.open_split()
  end,

  -- terminal height for build / test, only valid with `open_terminal_method=open_split()`
  terminal_height = 8,

  -- Picker mappings
  node_picker_mappings = function(map)
      map("n", "<c-k>", vim_utils.open_terminal_with_format_cmd_entry("rosnode kill %s"))
      map("i", "<c-k>", vim_utils.open_terminal_with_format_cmd_entry("rosnode kill %s"))
  end,
  topic_picker_mappings = function(map)
      local cycle_previewers = function(prompt_bufnr)
          local picker = action_state.get_current_picker(prompt_bufnr)
          picker:cycle_previewers(1)
      end
      map("n", "<c-b>", vim_utils.open_terminal_with_format_cmd_entry("rostopic pub %s"))
      map("i", "<c-b>", vim_utils.open_terminal_with_format_cmd_entry("rostopic pub %s"))
      map("n", "<c-e>", cycle_previewers)
      map("i", "<c-e>", cycle_previewers)
  end,
  service_picker_mappings = function(map)
      map("n", "<c-e>", vim_utils.open_terminal_with_format_cmd_entry("rosservice call %s"))
      map("i", "<c-e>", vim_utils.open_terminal_with_format_cmd_entry("rosservice call %s"))
  end,
  param_picker_mappings = function(map)
      map("n", "<c-e>", vim_utils.open_terminal_with_format_cmd_entry("rosparam set %s"))
      map("i", "<c-e>", vim_utils.open_terminal_with_format_cmd_entry("rosparam set %s"))
  end,
}
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
