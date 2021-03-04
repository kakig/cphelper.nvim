local p = require "plenary.path"
local h = require "helpers"
local contests_dir = p.new(vim.loop.os_homedir()):joinpath("contests") -- TODO allow user to set this
local langs = {"c", "cpp", "py"}
local preferred_lang = h.vglobal_or_default("cphlang", "cpp")
local M = {}

function M.prepare_folders(problem, group)
  -- group = judge + contest
  local sep_pos = string.find(group, "% %-")
  local judge = h.sanitize(string.sub(group, 1, sep_pos))
  local contest = h.sanitize(string.sub(group, sep_pos + 1))

  problem = h.sanitize(problem)
  local problem_dir = contests_dir:joinpath(judge, contest, problem)
  contests_dir:mkdir()
  contests_dir:joinpath(judge):mkdir()
  contests_dir:joinpath(judge, contest):mkdir()
  problem_dir:mkdir()
  return problem_dir
end

function M.prepare_files(problem_dir, json)
  for i, test in pairs(json.tests) do
    problem_dir:joinpath("testinput" .. i):write(test["input"], "w")
    problem_dir:joinpath("testoutput" .. i):write(test["output"], "w")
    print("Wrote tests")
  end
  for _, lang in pairs(langs) do
    problem_dir:joinpath("solution." .. lang):touch()
  end
  vim.cmd([[e ]] .. problem_dir:joinpath("solution." .. preferred_lang):absolute())
end
return M
