return {
  "echasnovski/mini.completion",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("mini.completion").setup()

    local keys = {
      ['cr']        = vim.api.nvim_replace_termcodes('<CR>', true, true, true),
      ['ctrl-y']    = vim.api.nvim_replace_termcodes('<C-y>', true, true, true),
      ['ctrl-y_cr'] = vim.api.nvim_replace_termcodes('<C-y><CR>', true, true, true),
    }

    _G.cr_action = function()
      if vim.fn.pumvisible() ~= 0 then
        -- If popup is visible, confirm selected item or add new line otherwise
        local item_selected = vim.fn.complete_info()['selected'] ~= -1
        return item_selected and keys['ctrl-y'] or keys['ctrl-y_cr']
      else
        -- If popup is not visible, use plain `<CR>`. You might want to customize
        -- according to other plugins. For example, to use 'mini.pairs', replace
        -- next line with `return require('mini.pairs').cr()`
        return keys['cr']
      end
    end

    vim.keymap.set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
    vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
    vim.keymap.set('i', '<CR>', 'v:lua._G.cr_action()', { expr = true })
  end
}
