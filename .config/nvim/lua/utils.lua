local M = {}
local plenary = require('plenary')

function M.isInGitRepo()
  local ret = os.execute('git rev-list -1 HEAD >/dev/null 2>&1')
  return ret == 0
end

function M.contains(table, val)
  for _, v in pairs(table) do
    if v == val then
      return true
    end
  end
  return false
end

return M
