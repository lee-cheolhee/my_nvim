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
Plug 'EdenEast/nightfox.nvim'
" Plug 'shaunsingh/nord.nvim'
" Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

"*************
" etc.
"************
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'spf13/vim-autoclose'
Plug 'preservim/nerdcommenter'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}


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
Plug 'airblade/vim-gitgutter'
Plug 'xuyuanp/nerdtree-git-plugin'

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
" set number
" set relativenumber

" Normal 모드에서 cursorline 활성화
autocmd InsertLeave * set cursorline
" Insert 모드에서 cursorline 비활성화
autocmd InsertEnter * set nocursorline

" Better command line completion 
set wildmenu

" terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>
tnoremap <Esc> <C-\><C-n>

set mouse=
set clipboard+=unnamedplus
" "" Copy/Paste/Cut
" if has('unnamedplus')
  " set clipboard=unnamed,unnamedplus
" endif

" buffer switching
map <silent> <leader>z :bprev<CR>
map <silent> <leader>x :bnext<CR>
map <silent> <leader>d :bdelete<CR>

" colorscheme
let no_buffers_menu=1
set termguicolors
colorscheme carbonfox
set background=dark

" vim-airline theme
let g:airline_theme='alduin'
" vim-airline
let g:airline#extensions#tabline#enabled = 1              " vim-airline ë²í¼ ëª©ë¡ ì¼ê¸°
let g:airline#extensions#tabline#fnamemod = ':t'          " vim-airline ë²í¼ ëª©ë¡ íì¼ëªë§ ì¶ë ¥
let g:airline#extensions#tabline#buffer_nr_show = 1       " buffer numberë¥¼ ë³´ì¬ì¤ë¤
let g:airline#extensions#tabline#buffer_nr_format = '%s:' " buffer number format


" DoxygenToolkit
let g:DoxygenToolkit_briefTag_pre="@Synopsis  "
let g:DoxygenToolkit_paramTag_pre="@Param "
let g:DoxygenToolkit_returnTag="@Returns   "
let g:DoxygenToolkit_blockHeader="-------------------------------"
let g:DoxygenToolkit_blockFooter="---------------------------------"
let g:DoxygenToolkit_authorName="Mathias Lorente"
let g:DoxygenToolkit_licenseTag="My own license"

" NerdTree
nnoremap <C-n> :NERDTreeToggle<CR>

" Tagbar
nnoremap <C-t> :TagbarToggle<CR>

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

" indent guide
let g:indent_guides_enable_on_vim_startup = 0
" indent line
let g:indentLine_enabled = 1
""let g:indentLine_setColors = 0

" vim-autopep8
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>
let g:autopep8_ignore="E501,W293"

" vim-nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
" learder + c + c: commnet toggle
vnoremap <leader>cc :call NERDComment(0, 'toggle')<CR>


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
        "eslint",        -- JavaScript/TypeScript
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
}

for server, config in pairs(servers) do
    config.on_attach = on_attach
    lspconfig[server].setup(config)
end

local telescope = require('telescope')

telescope.setup {
    defaults = {
        file_ignore_patterns = { "node_modules", ".git" },
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
