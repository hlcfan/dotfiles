return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui", "leoluz/nvim-dap-go" },
    cmd = {
      "DapContinue",
      "DapToggleBreakpoint",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
      "DapTerminate",
      "DapToggleRepl",
    },
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Debug: continue",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: step over",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: step into",
      },
      {
        "<F12>",
        function()
          require("dap").step_out()
        end,
        desc = "Debug: step out",
      },
      {
        "<leader>wo",
        function()
          require("dapui").open()
        end,
        desc = "Open DAPUI",
      },
      {
        "<leader>wb",
        function()
          require("dapui").close()
        end,
        desc = "Close DAPUI",
      },
      {
        "<leader>wt",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
      },
      {
        "<leader>wc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
    },
    config = function()
      require("config.dap")
    end,
  },
  {
    "leoluz/nvim-dap-go",
    lazy = true,
    opts = {
      dap_configurations = {
        { type = "go", name = "Debug main.go", request = "launch", program = "${workspaceFolder}/main.go" },
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    dependencies = {
      "nvim-neotest/nvim-nio",
    },
  },
}
