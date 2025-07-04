-- ⚙️   Rsync helper utilities for FARMILY robots

local term = require("utils.terminal")  -- ⬅️ popup terminal 유틸

-------------------------------------------------
-- 1. 파일·디렉터리 제외 목록 -------------------
-------------------------------------------------
local exclude = {
  ".git", ".DS_Store", ".idea", ".vscode",
  "build/", "devel/", "log/", "logs/",
  "*.log", "cache/"
}

local function build_exclude_opts()
  return table.concat(
    vim.tbl_map(function(item) return (' --exclude="%s"'):format(item) end, exclude),
    ""
  )
end

-------------------------------------------------
-- 2. Rsync 커맨드 생성 --------------------------
-------------------------------------------------
local LOCAL_BASE  = "~/farmily_ws/src/"
local REMOTE_BASE = "rdv@192.168.75.4:/home/rdv/rdv_farmily/"

local function rsync(direction, subpath)
  local from, to
  local suffix = subpath and (subpath .. "/") or ""

  if direction == "up" then
    from = LOCAL_BASE .. suffix
    to   = REMOTE_BASE .. suffix
  else
    from = REMOTE_BASE .. suffix
    to   = LOCAL_BASE .. suffix
  end

  local cmd = ("rsync -avz --progress%s %s %s"):format(
    build_exclude_opts(), from, to
  )

  term.run_in_popup_terminal(cmd) -- 💥 popup 터미널로 실행
end

-------------------------------------------------
-- 3. User Command 정의 --------------------------
-------------------------------------------------
vim.api.nvim_create_user_command("RsyncUp", function(opts)
  rsync("up", opts.args ~= "" and opts.args or nil)
end, {
  nargs = "?",
  desc = "Rsync ⬆︎ local → remote [optional path]",
  complete = "dir"
})

vim.api.nvim_create_user_command("RsyncDown", function(opts)
  rsync("down", opts.args ~= "" and opts.args or nil)
end, {
  nargs = "?",
  desc = "Rsync ⬇︎ remote → local [optional path]",
  complete = "file"
})

-------------------------------------------------
-- 4. 실행 전 확인 프롬프트 ----------------------
-------------------------------------------------
local function confirm_rsync(direction)
  local sub = vim.fn.input("Subfolder to sync (empty = all): ")
  local path = sub ~= "" and sub or nil
  local choice = vim.fn.input(("Rsync %s %s ? (Y/n): "):format(direction, sub))
  if choice == "" or choice:lower() == "y" then
    rsync(direction, path)
  else
    vim.notify("Rsync canceled", vim.log.levels.INFO)
  end
end

-------------------------------------------------
-- 5. 키매핑 -------------------------------------
-------------------------------------------------
local map = vim.keymap.set
map("n", "<leader>ru", function() confirm_rsync("up") end,
  { silent = true, desc = "Rsync UP  (local → remote)" })
map("n", "<leader>rd", function() confirm_rsync("down") end,
  { silent = true, desc = "Rsync DOWN (remote → local)" })
