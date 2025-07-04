-- ~/.config/nvim/lua/plugins/build_tools.lua
-- local term = require("utils.terminal")

vim.g.build_tool = "colcon"            -- 필요할 때 "colcon" 으로 토글

----------------------------------------------------------------------
-- 명령 문자열 빌더 (패키지 선택 지원)
----------------------------------------------------------------------
local function build_cmd(pkg)
  if vim.g.build_tool == "catkin" then
    local base = "source /opt/ros/noetic/setup.bash && catkin config --install"
    local build = "catkin build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Release -j4"
    if pkg then build = build .. " " .. pkg end
    local post = "python3 /home/rdv/catkin_ws/merge_compile_commands.py"
    return ("bash -c '%s && %s && %s'"):format(base, build, post)
  else
    local base = "source /opt/ros/humble/setup.bash"
    local build = "colcon build --parallel-workers 4 --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Release"
    if pkg then build = build .. " --packages-select " .. pkg end
    return ("bash -c '%s && %s'"):format(base, build)
  end
end

local function clean_cmd(pkg)
  if vim.g.build_tool == "catkin" then
    return pkg and ("catkin clean --yes " .. pkg) or "catkin clean --yes"
  else -- colcon
    if pkg then
      -- colcon clean은 직접 지원하지 않으므로 수동 삭제 방식
      return ("rm -rf build/%s install/%s log"):format(pkg, pkg)
    else
      return "rm -rf build install log"
    end
  end
end

local function show_terminal_log(cmd)
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = math.floor(vim.o.columns * 0.7),
    height = math.floor(vim.o.lines * 0.5),
    row = math.floor(vim.o.lines * 0.25),
    col = math.floor(vim.o.columns * 0.15),
    border = "single",
    style = "minimal"
  })

  vim.fn.termopen(cmd)
  vim.cmd("startinsert")
end
----------------------------------------------------------------------
-- 공통 프롬프트 → 확인 → 실행 함수
----------------------------------------------------------------------
local function confirm_and_run(kind)   -- kind = "build" | "clean"
  local label = (kind == "build") and "Build" or "Clean"
  local pkg = vim.fn.input(label .. " package (empty=all): ")
  local cmd = (kind == "build") and build_cmd(pkg ~= "" and pkg or nil)
                             or  clean_cmd(pkg ~= "" and pkg or nil)

  local ok = vim.fn.input(label .. " " .. (pkg ~= "" and pkg or "all") .. " ? (Y/n): ")
  if ok == "" or ok:lower() == "y" then
    vim.notify("🚧 Build started: " .. cmd, vim.log.levels.INFO)
    show_terminal_log(cmd)  -- log를 popup으로 보여줌
  else
    vim.notify(label .. " canceled", vim.log.levels.INFO)
  end
end

----------------------------------------------------------------------
-- 키매핑: <leader>cb / <leader>cc
----------------------------------------------------------------------
vim.keymap.set("n", "<leader>cb", function() confirm_and_run("build") end,
  { desc = "[catkin/colcon] Build (prompt)", silent = true })

vim.keymap.set("n", "<leader>cc", function() confirm_and_run("clean") end,
  { desc = "[catkin/colcon] Clean (prompt)", silent = true })
