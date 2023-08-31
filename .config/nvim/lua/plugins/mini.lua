return {
  {
    "echasnovski/mini.ai",
    event = 'VeryLazy',
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- no need to load the plugin, since we only need its queries
          require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
        end,
      },
    },
    config = function()
      local ai = require("mini.ai")
      ai.setup({
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      })
    end,
  },
  {
    "echasnovski/mini.move",
    event = 'VeryLazy',
    opts = {
      mappings = {
        left = '<M-h>',
        right = '<M-l>',
        down = '<M-j>',
        up = '<M-k>',

        line_left = '<M-h>',
        line_right = '<M-l>',
        line_down = '<M-j>',
        line_up = '<M-k>',
      }
    },
  },
  { "echasnovski/mini.align",     event = 'VeryLazy', opts = {} },
  { "echasnovski/mini.bracketed", event = 'VeryLazy', opts = {} },
  { "echasnovski/mini.comment",   event = 'VeryLazy', opts = { ignore_blank_line = true } },
  { "echasnovski/mini.splitjoin", event = 'VeryLazy', opts = { mappings = { toggle = 'gJ' } } },
  { "echasnovski/mini.surround",  event = 'VeryLazy', opts = {} },
  { "echasnovski/mini.pairs",     event = 'VeryLazy', opts = {} },
  {
    "echasnovski/mini.hipatterns",
    event = 'VeryLazy',
    config = function()
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
    end
  },
}
