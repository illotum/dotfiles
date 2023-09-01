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
  map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
  map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
  map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
  map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
  map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage" })
  map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset" })
  map("n", "<leader>gb", function() gs.blame_line{full=true} end, { desc = "Blame" })
  map('n', '<leader>gd', gs.diffthis, { desc = "Diff" })
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
