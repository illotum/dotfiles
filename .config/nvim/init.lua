-- vim: et
-- Settings
vim.cmd [[colorscheme flat]]
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.opt.breakindent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.cmdheight = 2
vim.opt.completeopt = 'menuone,noselect'
vim.opt.cursorline = true
vim.opt.foldexpr='nvim_treesitter#foldexpr()'
vim.opt.foldlevelstart = 0
vim.opt.foldmethod = 'expr'
vim.opt.foldminlines = 5
vim.opt.foldnestmax = 2
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.lazyredraw = true
vim.opt.mouse = 'a'
vim.opt.scrolloff = 5
vim.opt.secure = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 0
vim.opt.sidescrolloff = 5
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.softtabstop = -1
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.textwidth = 100
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.virtualedit = 'block,onemore'
vim.opt.wildmode = 'list:longest,full'
vim.opt.wrap = false

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Easy paste multiple lines
vim.api.nvim_set_keymap('n', 'p', 'p`]', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'p', 'p`]', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'y', 'y`]', { noremap = true, silent = true })

-- Easier horizontal scrolling
vim.api.nvim_set_keymap('', 'zl', 'zL', { noremap = true })
vim.api.nvim_set_keymap('', 'zh', 'zH', { noremap = true })

-- Allow using the repeat operator with a visual selection
vim.api.nvim_set_keymap('v', '.', ':normal .<CR>', { noremap = true })

-- Toggle search highlight
vim.api.nvim_set_keymap('n', '<Leader>/', ':set invhlsearch<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Esc><Esc>', '<CMD>nohlsearch<CR>', { noremap = true, silent = true })

-- Insert a newline in normal mode
vim.api.nvim_set_keymap('n', '<Leader>o', 'm`o<Esc>``', { noremap = true })

-- Visual shifting (does not exit Visual mode)
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true })

-- Clipboard yank
-- map('', '<Leader>y', '"+y')
-- map('', '<Leader>p', '"+p')

-- Highlight on yank
vim.cmd [[
    augroup YankHighlight
        autocmd!
        autocmd TextYankPost * silent! lua vim.highlight.on_yank()
    augroup end
]]

-- Diagnostics
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })
vim.fn.sign_define("DiagnosticSignError", { text = "✗", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "!", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

-- Extensions
local function cfgTelescope()
    require('telescope').setup {
        pickers = {
            find_files = { theme = "ivy" },
            buffers = { theme = "ivy" },
            live_grep = { theme = "ivy" },
            grep_string = { theme = "cursor" },
            tags = { theme = "ivy" },
            help_tags = { theme = "ivy" },
            lsp_code_actions = { theme = "cursor" },
            lsp_document_symbols = { theme = "ivy" },
            defaults = {
                mappings = {
                    i = {
                        ['<C-u>'] = false,
                        ['<C-d>'] = false,
                    },
                },
            },
        }
    }
    vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>?',  [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })
end
local function cfgGitsigns()
    require('gitsigns').setup {
        signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
        },
    }
end
local function cfgTreesitter()
    require('nvim-treesitter.configs').setup {
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = 'gnn',
                node_incremental = 'grn',
                scope_incremental = 'grc',
                node_decremental = 'grm',
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    [']m'] = '@function.outer',
                    [']]'] = '@class.outer',
                },
                goto_next_end = {
                    [']M'] = '@function.outer',
                    [']['] = '@class.outer',
                },
                goto_previous_start = {
                    ['[m'] = '@function.outer',
                    ['[['] = '@class.outer',
                },
                goto_previous_end = {
                    ['[M'] = '@function.outer',
                    ['[]'] = '@class.outer',
                },
            },
        },
    }
end
local function cfgLSP()
    local lspconfig = require('lspconfig')
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, 'lua/?.lua')
    table.insert(runtime_path, 'lua/?/init.lua')
    local servers = {
        erlangls = {},
        sumneko_lua = {
            cmd = {
                vim.fn.exepath("lua-language-server"),
                '-E',
                vim.fn.getenv('HOME')..'/src/lua-language-server/main.lua',
            },
            settings = {
                Lua = {
                    runtime = { version = 'LuaJIT', path = runtime_path },
                    diagnostics = { globals = { 'vim' }, disable = { 'lowercase-global' } },
                    workspace = { library = vim.api.nvim_get_runtime_file('*.lua', true) },
                    -- telemetry = { enable = false },
                },
            },
        },
        zls = {
            cmd = { vim.fn.exepath('zls') },
            filetypes = { 'zig' };
            root_dir = function(fname)
                return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
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
    -- nvim-cmp supports additional completion capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    -- Buffer config
    local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true }
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>sa', [[<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>]], opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
        if client.resolved_capabilities.type_definition then
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        end
        if client.resolved_capabilities.document_formatting then
            vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.formatting_sync()<CR>", opts)
            vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
        end
        if client.resolved_capabilities.document_range_formatting then
            vim.api.nvim_buf_set_keymap(bufnr, "x", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR><ESC>", opts)
        end
        vim.cmd [[
            augroup GoImportsOnSave
            autocmd!
            autocmd BufWritePre *.go lua goimports(250)
            augroup end
        ]]
    end
    for lsp, config in pairs(servers) do
        config.on_attach = on_attach
        config.capabilities = capabilities
        lspconfig[lsp].setup(config)
    end
end
local function cfgCmp()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    cmp.setup {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = {
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
            ['<Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end,
            ['<S-Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end,
        },
        sources = {
            { name = 'lspconfig' },
            { name = 'luasnip' },
        },
    }
end
local function cfgBlankLine()
    vim.g.indent_blankline_char = '┊'
    vim.g.indent_blankline_use_treesitter = true
    vim.g.indent_blankline_filetype = {'yaml'}
    vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile'}
    vim.g.indent_blankline_char_highlight = 'LineNr'
end
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

-- Packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end
vim.cmd [[
    augroup Packer
        autocmd!
        autocmd BufWritePost init.lua PackerCompile
    augroup end
]]
require('packer').startup(function(use)
    use 'haya14busa/incsearch.vim'
    use 'illotum/flat.nvim'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'romainl/flattened'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'wbthomason/packer.nvim'
    use 'zhimsel/vim-stay'
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = cfgTelescope }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = cfgTreesitter }
    use { 'hrsh7th/nvim-cmp', config = cfgCmp }
    use { 'L3MON4D3/LuaSnip', requires = { 'saadparwaiz1/cmp_luasnip' }, configure = function() require('luasnip') end }
    use { 'neovim/nvim-lspconfig', requires = { 'hrsh7th/cmp-nvim-lsp' }, config = cfgLSP }
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, tag = 'release', config = cfgGitsigns }
    use { 'lukas-reineke/indent-blankline.nvim', config = cfgBlankLine }
    use { 'luukvbaal/stabilize.nvim', config = function() require('stabilize').setup() end }
    use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
end)

