local o = vim.o
local wo = vim.wo
local g = vim.g

-- 기본 옵션
o.encoding, o.fileencoding = "utf-8", "utf-8"
o.tabstop, o.shiftwidth, o.softtabstop = 4, 4, 4
o.expandtab, o.autoindent, o.smartindent = true, true, true
o.hidden, o.hlsearch, o.incsearch = true, true, true
o.ignorecase, o.smartcase = true, true
o.backspace = "indent,eol,start"
o.mouse = ""
o.clipboard = "unnamed,unnamedplus"

-- 줄 번호
wo.number, wo.relativenumber = true, true
