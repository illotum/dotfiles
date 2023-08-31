local function init()
  require("mini.basics").setup({
    options = {
      basic = true,
      extra_ui = true,
      win_borders = 'default',
    },
    mappings = {
      basic = true,
      windows = true,
      option_toggle_prefix = [[,]],
      move_with_alt = true,
    },
    autocommands = {
      basic = true,
      relnum_in_visual_mode = true,
    },
    silent = true,
  })
  require("mini.ai").setup()
  require("mini.move").setup()
  require("mini.align").setup()
  require("mini.bracketed").setup()
  require("mini.comment").setup()
  require("mini.splitjoin").setup()
  require("mini.surround").setup()
  require("mini.pairs").setup()


  local hipatterns = require('mini.hipatterns')
  hipatterns.setup({
    highlighters = {
      fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
      hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
      todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
      note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })

  vim.opt.concealcursor = 'nc'
  vim.opt.conceallevel = 2
  vim.opt.display = 'msgsep'
  vim.opt.expandtab = true
  vim.opt.fillchars = [[vert:│,horiz:─,eob: ]]
  vim.opt.foldenable = false
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
  vim.opt.foldlevelstart = 0
  vim.opt.foldmethod = 'expr'
  vim.opt.foldminlines = 5
  vim.opt.foldnestmax = 2
  vim.opt.hlsearch = true
  vim.opt.inccommand = 'nosplit'
  vim.opt.lazyredraw = true
  vim.opt.listchars = vim.o.listchars .. [[,tab:▸ ,trail:·]]
  vim.opt.modeline = false
  vim.opt.previewheight = 5
  vim.opt.scrolloff = 5
  vim.opt.secure = true
  vim.opt.shada = [['20,<50,s10,h,/100]]
  vim.opt.shiftround = true
  vim.opt.shiftwidth = 0
  vim.opt.showmatch = true
  vim.opt.sidescrolloff = 5
  vim.opt.softtabstop = -1
  vim.opt.swapfile = false
  vim.opt.switchbuf = 'useopen,uselast'
  vim.opt.synmaxcol = 500
  vim.opt.tabstop = 2
  vim.opt.textwidth = 100
  vim.opt.timeoutlen = 400
  vim.opt.updatetime = 100
  vim.opt.wildignore = { '*.o', '*~', '*.pyc' }
  vim.opt.wildmode = 'list:longest,full'

  -- Easy paste multiple lines
  vim.keymap.set('n', 'p', 'p`]', { silent = true, noremap = true })
  vim.keymap.set('v', 'p', 'p`]', { silent = true, noremap = true })
  vim.keymap.set('v', 'y', 'y`]', { silent = true, noremap = true })

  -- Easier horizontal scrolling
  vim.keymap.set('', 'zl', 'zL', { desc = "Half screen to the right" })
  vim.keymap.set('', 'zh', 'zH', { desc = "Half screen to the left" })

  -- Allow using the repeat operator with a visual selection
  vim.keymap.set('v', '.', ':normal .<CR>')

  vim.filetype.add({
    extension = {
      escript = "erlang",
      recipe  = "markdown",
      config  = { "erlang", { priority = 10 } },
      app     = { "erlang", { priority = 10 } },
      conf    = { "systemd", { priority = 10 } }
    },
  })
end

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },
  {
    "illotum/flat.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme flat]]
    end
  },
  {
    "echasnovski/mini.nvim",
    lazy = false,
    priority = 999,
    config = init,
  },
}
