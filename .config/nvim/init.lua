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
    vim.api.nvim_set_keymap('','n','<Plug>(incsearch-nohl-n)', {})
    vim.api.nvim_set_keymap('','N','<Plug>(incsearch-nohl-N)', {})
    vim.api.nvim_set_keymap('','*','<Plug>(incsearch-nohl-*)', {})
    vim.api.nvim_set_keymap('','#','<Plug>(incsearch-nohl-#)', {})
    vim.api.nvim_set_keymap('','g*','<Plug>(incsearch-nohl-g*)', {})
    vim.api.nvim_set_keymap('','g#','<Plug>(incsearch-nohl-g#)', {})
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

local function cfgLspInstall()
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
    local lsp_installer = require("nvim-lsp-installer")
    for name, _ in pairs(servers) do
        local server_is_found, server = lsp_installer.get_server(name)
        if server_is_found and not server:is_installed() then
            print("Installing " .. name)
            server:install()
        end
    end
    lsp_installer.on_server_ready(function(server)
        local opts = {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = servers[server.name],
        }
        server:setup(opts)
    end)
end

local function cfgEasyAlign()
    vim.api.nvim_set_keymap('x', '<Leader>ta', '<Plug>(EasyAlign)', {})
    vim.api.nvim_set_keymap('n', '<Leader>ta', '<Plug>(EasyAlign)', {})
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
    use {
        'Glench/Vim-Jinja2-Syntax',
        'dcampos/cmp-snippy',
        'dcampos/nvim-snippy',
        'honza/vim-snippets',
        'hrsh7th/cmp-nvim-lsp',
        'illotum/flat.nvim',
        'neovim/nvim-lspconfig',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'tpope/vim-fugitive',
        'tpope/vim-repeat',
        'tpope/vim-surround',
        'wbthomason/packer.nvim',
        'zhimsel/vim-stay',
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
        { 'williamboman/nvim-lsp-installer', config = cfgLspInstall },
    }
end)

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
vim.diagnostic.config({
  underline = false,
  virtual_text = false,
  signs = true,
  severity_sort = true,
})
