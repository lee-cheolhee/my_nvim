-- ~/.config/nvim/lua/plugins/build_tools.lua

vim.g.build_tool = "catkin" -- "catkin" or "colcon"

local function run_in_terminal(cmd)
  vim.cmd("botright split")
  vim.cmd("resize 15")
  vim.fn.termopen(cmd)
end

-- 전체 or 선택 빌드 명령 생성
local function get_build_command(pkg)
  local tool = vim.g.build_tool

  if tool == "catkin" then
    local base = "source /opt/ros/noetic/setup.bash && catkin config --install"
    local build = "catkin build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Release -j4"
    if pkg then build = build .. " " .. pkg end
    local post = "python3 /home/rdv/catkin_ws/merge_compile_commands.py"
    return ("bash -c '%s && %s && %s'"):format(base, build, post)

  elseif tool == "colcon" then
    local base = "source /opt/ros/humble/setup.bash"
    local build = "colcon build --parallel-workers 4 --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Release"
    if pkg then build = build .. " --packages-select " .. pkg end
    return ("bash -c '%s && %s'"):format(base, build)
  end
end

-- 전체 or 선택 clean 명령 생성
local function get_clean_command(pkg)
  local tool = vim.g.build_tool
  if tool == "catkin" then
    return pkg and ("catkin clean --yes " .. pkg) or "catkin clean --yes"
  elseif tool == "colcon" then
    return "rm -rf build install log"
  end
end

-- :Build [pkg]
vim.api.nvim_create_user_command("Build", function(opts)
  run_in_terminal(get_build_command(opts.args ~= "" and opts.args or nil))
end, {
  nargs = "?",
  desc = "Build with optional package name"
})

-- :Clean [pkg]
vim.api.nvim_create_user_command("Clean", function(opts)
  run_in_terminal(get_clean_command(opts.args ~= "" and opts.args or nil))
end, {
  nargs = "?",
  desc = "Clean with optional package name"
})


-- 단축키
local map = vim.keymap.set
map("n", "<leader>cb", ":Build<Space>", { desc = "[catkin/colcon] build 패키지 선택 가능" })
map("n", "<leader>cl", ":Clean<Space>", { desc = "[catkin/colcon] clean 패키지 선택 가능" })
