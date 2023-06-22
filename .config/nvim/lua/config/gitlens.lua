local api = vim.api
local bo = vim.bo

local M = {}
local bt_blacklist = { 'help', 'terminal' }
local utils = require('config.utils')
local text
local lens_displayed = false
local gitlens_ns = api.nvim_create_namespace("gitlens")

function M.blameVirtText()
  local ft = vim.fn.expand('%:h:t')
  if ft == '' or ft == 'bin' then
    return
  end
  api.nvim_buf_clear_namespace(0, gitlens_ns, 0, -1)
  local currFile = vim.fn.expand('%')
  local line = api.nvim_win_get_cursor(0)
  local blame = vim.fn.system(string.format('git blame -c -L %d,%d %s', line[1], line[1], currFile))
  local hash = vim.split(blame, '%s')[1]
  local cmd = string.format('git show %s ', hash) .. "--format='      %an | %ar | %s'"
  if hash == '00000000' then
    text = 'Not Committed yet'
  else
    text = vim.fn.system(cmd)
    text = vim.split(text, '\n')[1]
    if text:find("fatal") then
      text = 'Not Committed yet'
    end
  end
  -- api.nvim_buf_set_virtual_text(0,gitlens_ns,line[1]-1, {{ text, 'GitLensText' }}, {})
  api.nvim_buf_set_extmark(0, gitlens_ns, line[1] - 1, line[2], {
    virt_text = { { text, 'GitLensText' } }
  })
  lens_displayed = true
end

function M.clearBlameVirtText()
  if not lens_displayed then
    return
  end
  lens_displayed = false
  api.nvim_buf_clear_namespace(0, gitlens_ns, 0, -1)
end

local function createGitLensAutocmds()
  api.nvim_create_augroup("GitLens", {})
  if utils.isInGitRepo() and not utils.contains(bt_blacklist, bo.buftype) then
    api.nvim_create_autocmd("CursorHold", {
      group = "GitLens",
      callback = M.blameVirtText
    })
    api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = "GitLens",
      callback = M.clearBlameVirtText
    })
  end
end

--
-- local function clearGitLensAutocmds(...)
--     api.nvim_clear_autocmds({ group = "GitLens" })
-- end
--
function M.setup()
  createGitLensAutocmds()

  api.nvim_create_autocmd({ "DirChanged", "BufEnter" }, {
    callback = createGitLensAutocmds
  })

end

return M
