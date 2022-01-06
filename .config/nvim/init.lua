-- vim: ts=2:et:tw=78:fmr={,}:foldlevel=0:fdm=marker
-- Init {
cmd = vim.cmd
fn = vim.fn
g = vim.g

function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


function smap(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end
-- }
-- Packages {
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  cmd 'packadd packer.nvim'
end
cmd 'autocmd BufWritePost init.lua PackerCompile'

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'b3nj5m1n/kommentary'
  use 'tpope/vim-sleuth'
  use 'kopischke/vim-stay'
  use 'haya14busa/incsearch.vim'
  use 'junegunn/vim-easy-align'
  use 'liuchengxu/vim-which-key'
  use 'kosayoda/nvim-lightbulb'
  use 'lukas-reineke/indent-blankline.nvim'
  use {'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'kyazdani42/nvim-web-devicons'}
    }
  }
  use {'nvim-treesitter/nvim-treesitter',
    branch = '0.5-compat',
    run = ':TSUpdate'
    }
  use {'nvim-treesitter/nvim-treesitter-textobjects',
    requires = {
      {'nvim-treesitter/nvim-treesitter'}
    }
  }
  use {'luukvbaal/stabilize.nvim',
    config = function() require('stabilize').setup() end
  }
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'tpope/vim-fugitive'
  use {'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    tag = 'release',
    config = function()
      require('gitsigns').setup()
    end
  }
  -- Erlang
  use 'vim-erlang/vim-erlang-runtime'
  use 'vim-erlang/vim-erlang-compiler'
  use 'vim-erlang/vim-erlang-skeletons'
  -- Colors
  use 'romainl/flattened'
  use 'folke/tokyonight.nvim'
  use 'shaunsingh/nord.nvim'
end)
-- }
-- Settings {
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.textwidth = 78
vim.opt.undofile = true
vim.opt.autowrite = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.cmdheight = 2
vim.opt.foldlevelstart = 10
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.joinspaces = false
vim.opt.lazyredraw = true
vim.opt.listchars = 'tab:›\\ ,trail:.,extends:#,nbsp:.'
vim.opt.mouse = 'a'
vim.opt.pastetoggle = '<F3>'
vim.opt.scrolloff = 5
vim.opt.secure = true
vim.opt.shiftround = true
vim.opt.sidescrolloff = 5
vim.opt.smartcase = true
vim.opt.splitbelow = false
vim.opt.splitright = false
vim.opt.switchbuf = 'useopen'
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
vim.opt.updatetime = 250
vim.opt.virtualedit = 'block,onemore'
vim.opt.visualbell = true
vim.opt.whichwrap = 'b,s,<,>,[,]'
vim.opt.wildmode = 'list:longest,full'
vim.opt.breakindent = true
vim.opt.cursorline = true
vim.opt.foldmethod = 'syntax'
vim.opt.foldminlines = 5
vim.opt.foldnestmax = 2
vim.opt.signcolumn = 'yes'
vim.opt.wrap = false

g.loaded_python3_provider = 0
g.loaded_python_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0
g.loaded_node_provider = 0
g.loaded_netrw            = 1
g.loaded_netrwPlugin      = 1
g.loaded_matchparen       = 1
g.loaded_matchit          = 1
g.loaded_2html_plugin     = 1
g.loaded_getscriptPlugin  = 1
g.loaded_gzip             = 1
g.loaded_logipat          = 1
g.loaded_rrhelper         = 1
g.loaded_spellfile_plugin = 1
g.loaded_tarPlugin        = 1
g.loaded_vimballPlugin    = 1
g.loaded_zipPlugin        = 1
-- }
-- Mappings {
smap('', '<Space>', '<Nop>')
g.mapleader = ' '
g.maplocalleader = ','

-- map('', '<Leader>y', '"+y') -- Clipboard yank
-- map('', '<Leader>p', '"+p') -- Clipboard paste
map('i', '<C-u>', '<C-g>u<C-u>')  -- Make <C-u> undo-friendly
map('i', '<C-w>', '<C-g>u<C-w>')  -- Make <C-w> undo-friendly
map('n', '<Leader>o', 'm`o<Esc>``')  -- Insert a newline in normal mode
smap('n', '<Leader>/', ':set invhlsearch<CR>')
smap('n', '<Esc><Esc>', '<CMD>nohlsearch<CR>')
map('v', '.', ':normal .<CR>') -- Allow using the repeat operator with a visual selection

-- Easier horizontal scrolling
map('', 'zl', 'zL')
map('', 'zh', 'zH')

-- Visual shifting (does not exit Visual mode)
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Smart j/k when 'wrap'
smap('n', 'k', "v:count == 0 ? 'gk' : 'k'", {expr = true})
smap('n', 'j', "v:count == 0 ? 'gj' : 'j'", {expr = true})

-- Easy paste multiple lines
smap('n', 'p', 'p`]')
smap('v', 'p', 'p`]')
smap('v', 'y', 'y`]')

-- Highlight copied text
cmd([[autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=100}]])
-- }

-- Colors {
-- vim.opt.termguicolors = true
vim.api.nvim_exec([[
  aug custom_highlight
  au!

  au ColorScheme * hi clear SignColumn
  au ColorScheme * hi clear LineNr
  au ColorScheme * hi clear SpecialKey
  au ColorScheme * hi clear CursorLineNr

  au ColorScheme * hi DiagnosticDefaultError ctermfg=1 guifg=#dc322f
  au ColorScheme * hi DiagnosticDefaultInformation  ctermfg=2 guifg=#719e07 guisp=#719e07
  au ColorScheme * hi DiagnosticDefaultWarning ctermfg=3 guifg=#b58900 guisp=#b58900
  au ColorScheme * hi DiagnosticDefaultHint ctermfg=4 guifg=#2aa198

  au ColorScheme * hi DiagnosticUnderlineError cterm=undercurl gui=undercurl guisp=#dc322f
  au ColorScheme * hi DiagnosticUnderlineInformation cterm=undercurl gui=undercurl guisp=#719e07
  au ColorScheme * hi DiagnosticUnderlineWarning cterm=undercurl gui=undercurl guisp=#b58900
  au ColorScheme * hi DiagnosticUnderlineHint cterm=undercurl gui=undercurl guisp=#2aa198

  au colorscheme * hi link GitSignsDelete DiagnosticDefaultError
  au colorscheme * hi link GitSignsAdd    DiagnosticDefaultInformation
  au colorscheme * hi link GitSignsChange DiagnosticDefaultWarning

  aug END
]], false)
cmd 'colorscheme flattened_dark'
-- }
-- incsearch {
    config = function()
      g['incsearch#auto_nohlsearch'] = 1
      vim.api.nvim_set_keymap('','n','<Plug>(incsearch-nohl-n)', {})
      vim.api.nvim_set_keymap('','N','<Plug>(incsearch-nohl-N)', {})
      vim.api.nvim_set_keymap('','*','<Plug>(incsearch-nohl-*)', {})
      vim.api.nvim_set_keymap('','#','<Plug>(incsearch-nohl-#)', {})
      vim.api.nvim_set_keymap('','g*','<Plug>(incsearch-nohl-g*)', {})
      vim.api.nvim_set_keymap('','g#','<Plug>(incsearch-nohl-g#)', {})
    end
-- }
-- EasyAlign {
vim.api.nvim_set_keymap('x', '<Leader>ta', '<Plug>(EasyAlign)', {})
vim.api.nvim_set_keymap('n', '<Leader>ta', '<Plug>(EasyAlign)', {})
-- }
-- WhichKey {
g.which_key_use_floating_win = 1
cmd 'hi clear WhichKey'
cmd 'hi clear WhichKeyDesc'
cmd 'hi clear WhichKeySeperator'
cmd 'hi clear WhichKeyGroup'
cmd 'hi clear WhichKeyFloating'
smap('n', '<Leader>', [[<CMD>WhichKey '<Space>'<CR>]])
smap('n', '<LocalLeader>', [[<CMD>WhichKey ','<CR>]])
-- }
-- LightBulb {
fn.sign_define('LightBulbSign', { text = "!", texthl = "", linehl="", numhl="" })
cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
-- }
-- Indent {
g.indent_blankline_char = '┊'
g.indent_blankline_use_treesitter = true
g.indent_blankline_filetype = {'yaml'}
g.indent_blankline_buftype_exclude = { 'terminal', 'nofile'}
g.indent_blankline_char_highlight = 'LineNr'
-- }
-- Telescope {
require('telescope').setup({
  pickers = {
    find_files = {
      theme = "ivy",
    },
    live_grep = {
      theme = "ivy",
    },
    tags = {
      theme = "ivy",
    },
    help_tags = {
      theme = "ivy",
    },
    lsp_code_actions = {
      theme = "cursor",
    },
  },
})
smap('n', '<Leader>ff', [[<CMD>lua require('telescope.builtin').find_files()<CR>]])
smap('n', '<Leader>fg', [[<CMD>lua require('telescope.builtin').live_grep()<CR>]])
smap('n', '<Leader>ft', [[<CMD>lua require('telescope.builtin').tags()<CR>]])
smap('n', '<Leader>fh', [[<CMD>lua require('telescope.builtin').help_tags()<CR>]])
-- }
-- TreeSitter {
require'nvim-treesitter.configs'.setup {
  ensure_installed = {'python', 'lua', 'go', 'json', 'yaml', 'toml', 'bash', 'comment'},
  highlight = {enable = true},
  indent = {enable = true},
}
-- }
-- LSP {
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local opts = {noremap = true, silent = true}
  buf_set_keymap('n', 'gD', '<CMD>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<CMD>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<CMD>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<CMD>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<CMD>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Leader>wa', '<CMD>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wr', '<CMD>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wl', '<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<Leader>D', '<CMD>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', '<CMD>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<CMD>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<Leader>ca', [[<CMD>lua require('telescope.builtin').lsp_code_actions()<CR>]], opts)
  buf_set_keymap('n', '<Leader>e', '<CMD>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<CMD>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<CMD>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<Leader>q', '<CMD>lua vim.diagnostic.setloclist()<CR>', opts)
  -- Gofmt and goimports on save
  cmd [[autocmd BufWritePre *.go lua goimports(250)]]
  -- Set some key bindings conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting_sync()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("x", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR><ESC>", opts)
  end
end
-- Default configs:
local servers = {
  erlangls = {},
  sumneko_lua = {
    cmd = {
      vim.fn.exepath("lua-language-server"),
      '-E',
      fn.getenv('HOME')..'/src/lua-language-server/main.lua',
    },
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          globals = {'vim'},
          disable = {'lowercase-global'}
        },
        workspace = {
          library = {
            [fn.expand('$VIMRUNTIME/lua')] = true,
            [fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
      },
    },
  },
  zls = {
    cmd = {vim.fn.exepath('zls')},
    filetypes = {'zig'};
    root_dir = function(fname)
      return nvim_lsp.util.find_git_ancestor(fname) or vim.loop.os_homedir()
    end;
    settings = {};
  },
  gopls = {
    cmd = {"gopls", "serve"},
    settings = {
      gopls = {
        hoverKind = "SynopsisDocumentation",
        usePlaceholders = true,
        gofumpt = true,
        analyses = {
          nilness = true,
          fieldalignment = true,
          unusedparams = true,
          unusedwrite = true,
        },
        staticcheck = true,
      },
    },
  },
}
for lsp, config in pairs(servers) do
  config.on_attach = on_attach
  nvim_lsp[lsp].setup(config)
end
-- Gofmt and goimports via LSP
function _G.goimports(timeout_ms)
  vim.lsp.buf.formatting_sync(nil, timeout_ms) -- Format first
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, 't', true } }
  local params = vim.lsp.util.make_range_params()
  params.context = context
  local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, timeout_ms)
  if not result or next(result) == nil then return end
  local actions = result[1].result
  if not actions then return end
  local action = actions[1]
  if action.edit or type(action.command) == 'table' then
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit)
    end
    if type(action.command) == 'tabl' then
      vim.lsp.buf.execute_command(action.command)
    end
  else
    vim.lsp.buf.execute_command(action)
  end
end

-- Change diagnostic signs.
vim.fn.sign_define("DiagnosticSignError", { text = "✗", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "!", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

-- global config for diagnostic
vim.diagnostic.config({
  underline = false,
  virtual_text = false,
  signs = true,
  severity_sort = true,
})
-- }
-- Compe {
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;
  source = {
    path = true;
    buffer = false;
    calc = true;
    vsnip = false;
    nvim_lsp = true;
    nvim_lua = true;
    spell = false;
    tags = false;
    snippets_nvim = false;
    treesitter = true;
  };
}
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local check_back_space = function()
    local col = fn.col('.') - 1
    if col == 0 or fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end
-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if fn.pumvisible() == 1 then
    return t '<C-n>'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if fn.pumvisible() == 1 then
    return t '<C-p>'
  else
    return t '<S-Tab>'
  end
end
map('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
map('s', '<Tab>', 'v:lua.tab_complete()', {expr = true})
map('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
map('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
-- }
-- Fugitive {
smap('n', '<Leader>dh', ':diffget //2<CR>')
smap('n', '<Leader>dl', ':diffget //3<CR>')
smap('n', '<Leader>gs', ':Gstatus<CR>')
smap('n', '<Leader>gd', ':Gvdiff!<CR>')
smap('n', '<Leader>gc', ':Gcommit<CR>')
smap('n', '<Leader>gb', ':Gblame<CR>')
smap('n', '<Leader>gl', ':Glog<CR>')
smap('n', '<Leader>gp', ':Git push<CR>')
smap('n', '<Leader>gr', ':Gread<CR>')
smap('n', '<Leader>gw', ':Gwrite<CR>')
smap('n', '<Leader>ge', ':Gedit<CR>')
smap('n', '<Leader>gi', ':Git add -p %<CR>')
smap('n', '<Leader>gg', ':SignifyToggle<CR>')
-- }
