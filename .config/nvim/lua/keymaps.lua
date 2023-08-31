local silent = { silent = true, noremap = true }

-- Easy paste multiple lines
vim.keymap.set('n', 'p', 'p`]', silent)
vim.keymap.set('v', 'p', 'p`]', silent)
vim.keymap.set('v', 'y', 'y`]', silent)

-- Clipboard yank
-- map('', '<Leader>y', '"+y')
-- map('', '<Leader>p', '"+p')

-- Easier horizontal scrolling
vim.keymap.set('', 'zl', 'zL', {desc = "Half screen to the right"})
vim.keymap.set('', 'zh', 'zH', {desc = "Half screen to the left"})

-- Allow using the repeat operator with a visual selection
vim.keymap.set('v', '.', ':normal .<CR>')

-- Toggle search highlight
vim.keymap.set('n', '<Leader>/', ':set invhlsearch<CR>', vim.tbl_extend('keep', { desc = "Hide search" }, silent))
vim.keymap.set('n', '<Esc><Esc>', '<CMD>nohlsearch<CR>', vim.tbl_extend('keep', { desc = "Clear search" }, silent))

-- Insert a newline in normal mode
vim.keymap.set('n', '<Leader>o', 'm`o<Esc>``', {desc = "Append newline"})
