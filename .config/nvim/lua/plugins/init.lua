return {
  {
    "illotum/flat.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme flat]]
    end
  },
  "echasnovski/mini.basics",
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  }
}
