local function set_keymaps(bufnr)
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  local function next_hunk()
    if vim.wo.diff then return ']g' end
    vim.schedule(function() gs.next_hunk() end)
    return '<Ignore>'
  end

  local function prev_hunk()
    if vim.wo.diff then return '[g' end
    vim.schedule(function() gs.next_hunk() end)
    return '<Ignore>'
  end

  map("n", "]g", next_hunk, { expr = true, desc = "Git hunk forward" })
  map("n", "[g", prev_hunk, { expr = true, desc = "Git hunk backward" })
  map("n", "<leader>gs", gs.stage_hunk, { desc = "Git stage hunk" })
  map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Git undo stage hunk" })
  map("n", "<leader>gr", gs.reset_hunk, { desc = "Git reset hunk" })
  map("n", "<leader>gp", gs.preview_hunk, { desc = "Git preview hunk" })
  map("n", "<leader>gS", gs.stage_buffer, { desc = "Git stage" })
  map("n", "<leader>gR", gs.reset_buffer, { desc = "Git reset" })
  map("n", "<leader>gb", function() gs.blame_line{full=true} end, { desc = "Git blame" })
  map('n', '<leader>gd', gs.diffthis, { desc = "Git diff" })
end

return {
  {
    'lewis6991/gitsigns.nvim',
    cmd = "Gitsigns",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        on_attach = set_keymaps
      })
    end
  }
}
