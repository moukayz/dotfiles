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

function M.addKeymap(keymap_list)
  for _, item in ipairs(keymap_list) do
    vim.keymap.set(unpack(item))
  end
end

local function test()
  maps = {
    { 'n', 'lhs',               'function() print("real lua function") end' },
    { 'n', '<leader>ps',        '<cmd>PackerStatus<cr>' },
  }
  M.addKeymap(maps)
end

-- test()

function _G.ReloadConfig()
  for name,_ in pairs(package.loaded) do
    -- if name:match('^user') and not name:match('nvim-tree') then
      vim.notify(name , vim.log.levels.INFO)
      -- package.loaded[name] = nil
    -- end
  end

  -- dofile(vim.env.MYVIMRC)
  -- vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end

return M
