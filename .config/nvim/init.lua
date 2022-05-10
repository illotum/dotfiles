-- vim: et
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
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader><space>', '', { callback = builtin.buffers })
    vim.keymap.set('n', '<leader>ff',      '', { callback = builtin.find_files })
    vim.keymap.set('n', '<leader>fb',      '', { callback = builtin.current_buffer_fuzzy_find })
    vim.keymap.set('n', '<leader>fh',      '', { callback = builtin.help_tags })
    vim.keymap.set('n', '<leader>ft',      '', { callback = builtin.tags })
    vim.keymap.set('n', '<leader>fd',      '', { callback = builtin.grep_string })
    vim.keymap.set('n', '<leader>fp',      '', { callback = builtin.live_grep })
    vim.keymap.set('n', '<leader>?',       '', { callback = builtin.oldfiles })
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
        ensure_installed = {
            'bash',
            'dockerfile',
            'dot',
            'elixir',
            'erlang',
            'fish',
            'go',
            'gomod',
            'gowork',
            'help',
            'http',
            'java',
            'json',
            'lua',
            'make',
            'markdown',
            'python',
            'regex',
            'ruby',
            'toml',
            'typescript',
            'vim',
            'yaml',
            'zig',
        },
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

local function cfgCmp()
    local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end
    local cmp = require('cmp')
    local snippy = require('snippy')
    cmp.setup {
        snippet = {
            expand = function(args)
                snippy.expand_snippet(args.body)
            end,
        },
        mapping = {
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif snippy.can_expand_or_advance() then
                    snippy.expand_or_advance()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif snippy.can_jump(-1) then
                    snippy.previous()
                else
                    fallback()
                end
            end, { "i", "s" }),
        },
        sources = {
            { name = 'nvim_lsp' },
            { name = 'snippy' },
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

local function cfgIncSearch()
    vim.g['incsearch#auto_nohlsearch'] = 1
    vim.keymap.set('','n','<Plug>(incsearch-nohl-n)')
    vim.keymap.set('','N','<Plug>(incsearch-nohl-N)')
    vim.keymap.set('','*','<Plug>(incsearch-nohl-*)')
    vim.keymap.set('','#','<Plug>(incsearch-nohl-#)')
    vim.keymap.set('','g*','<Plug>(incsearch-nohl-g*)')
    vim.keymap.set('','g#','<Plug>(incsearch-nohl-g#)')
end

local function cfgRest()
    require("rest-nvim").setup({
        -- Open request results in a horizontal split
        result_split_horizontal = false,
        -- Skip SSL verification, useful for unknown certificates
        skip_ssl_verification = false,
        -- Highlight request on run
        highlight = {
            enabled = true,
            timeout = 150,
        },
        result = {
            -- toggle showing URL, HTTP info, headers at top the of result window
            show_url = true,
            show_http_info = true,
            show_headers = true,
        },
        -- Jump to request line on run
        jump_to_request = false,
        env_file = '.env',
        custom_dynamic_variables = {},
        yank_dry_run = true,
    })
end

local function cfgLSP()
    local function goimports(timeout_ms)
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
    vim.api.nvim_create_autocmd("BufWritePre", { pattern = "*.go", callback = function() goimports(250) end })
    local on_attach = function(client, bufnr)
        local telescope_builtin = require('telescope.builtin')
        vim.keymap.set('n', 'gD',         '', { silent = true, buffer = bufnr, callback = vim.lsp.buf.declaration } )
        vim.keymap.set('n', 'gd',         '', { silent = true, buffer = bufnr, callback = vim.lsp.buf.definition } )
        vim.keymap.set('n', 'K',          '', { silent = true, buffer = bufnr, callback = vim.lsp.buf.hover })
        vim.keymap.set('n', 'gi',         '', { silent = true, buffer = bufnr, callback = vim.lsp.buf.implementation })
        vim.keymap.set('n', '<C-k>',      '', { silent = true, buffer = bufnr, callback = vim.lsp.buf.signature_help })
        vim.keymap.set('n', '<leader>wa', '', { silent = true, buffer = bufnr, callback = vim.lsp.buf.add_workspace_folder })
        vim.keymap.set('n', '<leader>wr', '', { silent = true, buffer = bufnr, callback = vim.lsp.buf.remove_workspace_folder })
        vim.keymap.set('n', '<leader>wl', '', { silent = true, buffer = bufnr, callback = function () print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end })
        vim.keymap.set('n', '<leader>rn', '', { silent = true, buffer = bufnr, callback = vim.lsp.buf.rename })
        vim.keymap.set('n', 'gr',         '', { silent = true, buffer = bufnr, callback = vim.lsp.buf.references })
        vim.keymap.set('n', '<leader>ca', '', { silent = true, buffer = bufnr, callback = vim.lsp.buf.code_action })
        vim.keymap.set('n', '<Leader>fa', '', { silent = true, buffer = bufnr, callback = telescope_builtin.lsp_code_actions })
        vim.keymap.set('n', '<leader>fo', '', { silent = true, buffer = bufnr, callback = telescope_builtin.lsp_document_symbols })
        if client.resolved_capabilities.type_definition then
            vim.keymap.set('n', '<leader>D', '', { silent = true, buffer = bufnr, callback = vim.lsp.buf.type_definition })
        end
        if client.resolved_capabilities.document_formatting then
            vim.keymap.set("n", "<space>f", "", { silent = true, buffer = bufnr, callback = vim.lsp.buf.formatting_sync })
        end
        if client.resolved_capabilities.document_range_formatting then
            vim.keymap.set("x", "<space>f", "", { silent = true, buffer = bufnr, callback = vim.lsp.buf.range_formatting })
        end
    end
    -- nvim-cmp supports additional completion capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, 'lua/?.lua')
    table.insert(runtime_path, 'lua/?/init.lua')
    local servers = {
        bashls = {},
        dockerls = {},
        erlangls = {},
        gopls = {
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
        jdtls = {},
        jsonls = {},
        lemminx = {},
        pyright = {},
        remark_ls = {},
        sumneko_lua = {
            Lua = {
                runtime = { version = 'LuaJIT', path = runtime_path },
                diagnostics = { globals = { 'vim' }, disable = { 'lowercase-global' } },
                workspace = { library = vim.api.nvim_get_runtime_file('*.lua', true) },
                telemetry = { enable = false },
            },
        },
        yamlls = {},
        zls = {},
    }
    require("nvim-lsp-installer").setup {} -- Server locator hook
    local lspconfig = require("lspconfig")
    for name, settings in pairs(servers) do
        lspconfig[name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = settings,
        }
    end
end

local function cfgEasyAlign()
    vim.keymap.set('x', '<Leader>ta', '<Plug>(EasyAlign)')
    vim.keymap.set('n', '<Leader>ta', '<Plug>(EasyAlign)')
end

-- Packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end
vim.api.nvim_create_autocmd("BufWritePost", { pattern = "init.lua", command = "PackerCompile" })

-- Install Packages
require('packer').startup(function(use)
    use {
        'Glench/Vim-Jinja2-Syntax',
        'dcampos/cmp-snippy',
        'dcampos/nvim-snippy',
        'honza/vim-snippets',
        'illotum/flat.nvim',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'tpope/vim-fugitive',
        'tpope/vim-repeat',
        'tpope/vim-surround',
        'wbthomason/packer.nvim',
        'zhimsel/vim-stay',
        { 'neovim/nvim-lspconfig', requires = { 'williamboman/nvim-lsp-installer', 'hrsh7th/cmp-nvim-lsp' }, config = cfgLSP },
        { 'NTBBloodbath/rest.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = cfgRest },
        { 'haya14busa/incsearch.vim', config = cfgIncSearch },
        { 'hrsh7th/nvim-cmp', config = cfgCmp },
        { 'junegunn/vim-easy-align', config = cfgEasyAlign },
        { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, tag = 'release', config = cfgGitsigns },
        { 'lukas-reineke/indent-blankline.nvim', config = cfgBlankLine },
        { 'luukvbaal/stabilize.nvim', config = function() require('stabilize').setup() end },
        { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end },
        { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = cfgTelescope },
        { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = cfgTreesitter },
    }
end)

-- Settings
vim.cmd [[colorscheme flat]]
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.do_filetype_lua = 1
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
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Easy paste multiple lines
vim.keymap.set('n', 'p', 'p`]', { silent = true })
vim.keymap.set('v', 'p', 'p`]', { silent = true })
vim.keymap.set('v', 'y', 'y`]', { silent = true })

-- Easier horizontal scrolling
vim.keymap.set('', 'zl', 'zL')
vim.keymap.set('', 'zh', 'zH')

-- Allow using the repeat operator with a visual selection
vim.keymap.set('v', '.', ':normal .<CR>')

-- Toggle search highlight
vim.keymap.set('n', '<Leader>/', ':set invhlsearch<CR>', { silent = true })
vim.keymap.set('n', '<Esc><Esc>', '<CMD>nohlsearch<CR>', { silent = true })

-- Insert a newline in normal mode
vim.keymap.set('n', '<Leader>o', 'm`o<Esc>``')

-- Visual shifting (does not exit Visual mode)
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Clipboard yank
-- map('', '<Leader>y', '"+y')
-- map('', '<Leader>p', '"+p')

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", { callback = function() vim.highlight.on_yank() end })

-- QF
vim.keymap.set('n', '[q', ':cprev<CR>', { silent = true })
vim.keymap.set('n', ']q', ':cnext<CR>', { silent = true })
vim.keymap.set('n', '<leader>q', ':cclose<CR>', { silent = true })

-- Diagnostics
vim.keymap.set('n', '<leader>e', '', { silent = true, callback = vim.diagnostic.open_float })
vim.keymap.set('n', '[d', '', { silent = true, callback = vim.diagnostic.goto_prev})
vim.keymap.set('n', ']d', '', { silent = true, callback = vim.diagnostic.goto_next })
vim.keymap.set('n', '<leader>d', '', { silent = true, callback = vim.diagnostic.setloclist })
vim.fn.sign_define("DiagnosticSignError", { text = "✗", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "!", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
vim.diagnostic.config({
  underline = false,
  virtual_text = false,
  signs = true,
  severity_sort = true,
})
