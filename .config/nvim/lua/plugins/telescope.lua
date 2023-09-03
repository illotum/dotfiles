return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = "VeryLazy",
  config = function()
    local themes = require('telescope.themes')
    local simple = themes.get_ivy({
      layout_config = {
        height = { 0.2, min = 5, max = 10, },
      }
    })
    local with_preview = themes.get_dropdown({
      layout_config = {
        height = { 0.2, min = 5, max = 10, },
      }
    })
    require('telescope').setup({
      defaults = with_preview,
      pickers = {
        find_files = simple,
        buffers = simple,
      },
    })
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = "Buffer" })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "File" })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help" })
    vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = "String" })
    -- LSP
    vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = "References" })
    vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { desc = "Symbols" })
    vim.keymap.set('n', '<leader>lS', builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })
  end

}
