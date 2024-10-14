local status_ok, dap = pcall(require, 'dap')
if not status_ok then
  return
end

local status_dapui_ok, dapui = pcall(require, 'dapui')
if not status_dapui_ok then
  return
end

-- local status_dapvtext_ok, dapvtext = pcall(require, 'nvim-dap-virtual-text')
-- if not status_dapvtext_ok then
--   return
-- end
--
-- dapvtext.setup()
--
vim.fn.sign_define('DapBreakpoint', { text='🐞', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })

-- dap UI config
dapui.setup({
  controls = {
    element = "repl",
    enabled = true,
    icons = {
      disconnect = "",
      pause = "",
      play = "",
      run_last = "",
      step_back = "",
      step_into = "",
      step_out = "",
      step_over = "",
      terminate = ""
    }
  },
  element_mappings = {},
  expand_lines = true,
  floating = {
    border = "single",
    mappings = {
      close = { "q", "<Esc>" }
    }
  },
  force_buffers = true,
  icons = {
    collapsed = "",
    current_frame = "",
    expanded = ""
  },
  layouts = {
    {
      elements = {
        "scopes"
      },
      size = 0.3,
      position = "bottom",
    },
    {
      elements = {
        "repl",
        "breakpoints"
      },
      size = 0.3,
      position = "right"
    },
  },
  mappings = {
    edit = "e",
    expand = { "t", "<2-LeftMouse>" },
    remove = "d",
    repl = {},
    open = {},
    toggle = {},
  },
  render = {
    indent = 1,
    max_value_lines = 100
  }
})

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

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = '/home/zmostafa/Downloads/codelldb-linux-x64/extension/adapter/codelldb',
    args = { "--port", "${port}" },

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}

-- CPP debug configurations
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
-- If you want to use this for Rust and C, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
