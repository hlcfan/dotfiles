local dap, dapui = require('dap'), require('dapui')

dapui.setup()
dap.listeners.before.attach.dapui_config = function()
 dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
 dapui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
 dapui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
 dapui.close()
end

local repl = require 'dap.repl'
repl.commands = vim.tbl_extend('force', repl.commands, {

  -- Add a new alias for existing commands
  exit = {'exit', '.exit'},

  -- Add new commands
  custom_commands = {
    ['.print'] = function(v)
      repl.execute(v)
    end,
  },
})
