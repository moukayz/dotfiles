local g = vim.g

if g.terminals == nil then
  g.terminals = {}
end
if g.last_terminal_nr == nil then
  g.last_terminal_nr = -1
end

local function NewTerminal(shell_param)
  local shell = vim.env.SHELL
  if (shell_param and vim.fn.executable(shell_param)) then
    shell = shell_param
  elseif vim.fn.executable('fish') then
    shell = 'fish'
  elseif vim.fn.executable('zsh') then
    shell = 'zsh'
  end

end
