-- ⚙️  Rsync helper utilities for FARMILY robots

-------------------------------------------------
-- 1. 파일·디렉터리 제외 목록 -------------------
-------------------------------------------------
local exclude = {
  ".git", ".DS_Store", ".idea", ".vscode",
  "build/", "devel/", "install/", "log/", "logs/",
  "*.log", "cache/"
}

-- → "--exclude=\"foo\" --exclude=\"bar\" …" 형태의 문자열로 변환
local function build_exclude_opts()
  return table.concat(
    vim.tbl_map(function(item) return (' --exclude="%s"'):format(item) end, exclude),
    ""
  )
end

-------------------------------------------------
-- 2. Rsync 커맨드 생성 --------------------------
-------------------------------------------------
-- 🏠 로컬·원격 경로(취향껏 수정!)
local LOCAL_SRC  = "~/catkin_ws/src/"
local REMOTE_SRC = "rdv@host:/home/rdv/path/"

vim.api.nvim_create_user_command("RsyncUp", function()
  local cmd = ("!rsync -avz --progress%s %s %s"):format(
    build_exclude_opts(), LOCAL_SRC, REMOTE_SRC
  )
  vim.cmd(cmd)
end, { desc = "Sync ⬆︎  local → remote" })

vim.api.nvim_create_user_command("RsyncDown", function()
  local cmd = ("!rsync -avz --progress%s %s %s"):format(
    build_exclude_opts(), REMOTE_SRC, LOCAL_SRC
  )
  vim.cmd(cmd)
end, { desc = "Sync ⬇︎  remote → local" })
-- 기본 경로 설정
local LOCAL_BASE  = "~/catkin_ws/src/"
local REMOTE_BASE = "rdv@host:/home/rdv/path/"

-- 유연하게 폴더를 인자로 받아 복사
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

  local cmd = ("!rsync -avz --progress%s %s %s"):format(
    build_exclude_opts(), from, to
  )
  vim.cmd(cmd)
end

-- :RsyncUp [subpath]
vim.api.nvim_create_user_command("RsyncUp", function(opts)
  rsync("up", opts.args ~= "" and opts.args or nil)
end, {
  nargs = "?",
  desc = "Rsync ⬆︎ local → remote [optional path]",
  complete = "dir"
})

-- :RsyncDown [subpath]
vim.api.nvim_create_user_command("RsyncDown", function(opts)
  rsync("down", opts.args ~= "" and opts.args or nil)
end, {
  nargs = "?",
  desc = "Rsync ⬇︎ remote → local [optional path]",
  complete = "file"
})

-------------------------------------------------
-- 3. 실행 전 확인 프롬프트 ----------------------
-------------------------------------------------
local function confirm_rsync(direction)
  local sub = vim.fn.input("Subfolder to sync (empty = all): ")
  local path = sub ~= "" and sub or nil
  local choice = vim.fn.input(("Rsync %s %s ? (y/n): "):format(direction, sub))
  if choice:lower() == "y" then
    rsync(direction, path)
  else
    vim.notify("Rsync canceled", vim.log.levels.INFO)
  end
end

-------------------------------------------------
-- 4. 편리한 키매핑 ------------------------------
-------------------------------------------------
local map = vim.keymap.set
map("n", "<leader>ru", function() confirm_rsync("up") end,
    { silent = true, desc = "Rsync UP  (local → remote)" })
map("n", "<leader>rd", function() confirm_rsync("down") end,
    { silent = true, desc = "Rsync DOWN (remote → local)" })

-------------------------------------------------
-- ✔︎ 끝! ---------------------------------------
-------------------------------------------------
-- ⚡️ 사용 예시:
--   · <leader>ru                → 동기화 올려보내기 (확인 창 뜸)
--   · <leader>rd                → 동기화 내려받기 (확인 창 뜸)
--   · :RsyncUp                  → 전체 local → remote 복사
--   · :RsyncUp packages/pkg_a   → packages/pkg_a만 복사
--   · :RsyncDown                → 전체 remote → local 복사
--   · :RsyncDown sensor_driver  → 해당 폴더만 내려받기

-- 필요하면 LOCAL_SRC / REMOTE_SRC, rsync 옵션 등을 마음껏 커스터마이징하세요.
