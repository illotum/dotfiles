require('vis')

-- require('plugins/surround/surround')
-- require('plugins/commentary/vis-commentary')
-- require('plugins/ctags/ctags')
-- cursors = require('plugins/cursors/cursors')
-- cursors.path = os.getenv('HOME') .. '/.config/vis/cursors'


-- global config
vis.events.subscribe(vis.events.INIT, function()
  vis:command('set theme solarized-fix')
  vis:command('set tabwidth 2')
  vis:command('set expandtab')
  vis:command('set autoindent')
end)

-- per-window config
vis.events.subscribe(vis.events.WIN_OPEN, function(win)
  if win.syntax == 'go' then
    vis:command('set tabwidth 4')
    vis:command('set expandtab off')
  end
  -- set commit message syntax to diff
  if win.file.name and win.file.name:find("COMMIT_EDITMSG") then
    vis:command('set colorcolumn 72')
    win:set_syntax("diff")
  end
end)

vis.events.subscribe(vis.events.FILE_SAVE_PRE, function(win)
  if win.syntax == 'go' then
    -- vis:command('gofmt')
  end
end)

-- require('plugins/filetype-settings/vis-filetype-settings')
-- settings = {
    -- go = {'expandtab off', 'tabwidth 4'}
-- }

vis:command_register('gofmt', function(argv, force, win, selection, range)
  -- local save_line, save_col = win.selection.line, win.selection.col
  vis:command(',|goimports')
  -- win.selection:to(save_line, save_col)
end, "Run goimports on the file")

vis:map(vis.modes.NORMAL, ';', ':')
