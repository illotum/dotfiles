vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    local map = function(provider, m, l, r, desc)
      if provider == "" or client.server_capabilities[provider .. 'Provider'] then
        vim.keymap.set(m, l, r, { desc = desc, silent = true, buffer = bufnr })
      end
    end

    map('hover', 'n', 'K', vim.lsp.buf.hover, "Hover info")
    map('definition', 'n', 'gd', vim.lsp.buf.definition, "Go to definition")
    map('rename', 'n', '<leader>ln', vim.lsp.buf.rename, "Rename")
    map('documentFormatting', "n", "<space>lf", vim.lsp.buf.format, "Format")
    map('documentFormatting', "n", "<space>la", vim.lsp.buf.code_action, "Actions")
  end,
})

-- TODO v0.10
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- local bufnr = args.buf

    -- Disable highlight
    client.server_capabilities.semanticTokensProvider = nil

    -- vim.lsp.buf.inlay_hint(bufnr,
    --   client.server_capabilities.inlayHintProvider ~= nil and client.server_capabilities.inlayHintProvider ~= false
    -- )
  end,
})

local servers = {
  lua_ls = {
    Lua = {
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file('*.lua', true)
      },
      diagnostics = {
        unusedLocalExclude = { '_*' },
        globals = { "vim", "vis" }
      },
      runtime = { version = 'LuaJIT' },
      telemetry = { enable = false }
    }
  },
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
  elixirls = {
    elixirLS = {
      enableTestLenses = true,
      fetchDeps = true,
    },
  },
  ltex = {
    ltex = {
      language = "en-US",
      dictionary = {
        ["en-US"] = {
          "AMQP",
          "Libera",
        }
      },
      additionalRules = {
        languageModel = '~/.ngrams',
        enablePickyRules = true,
        motherTongue = "en-CA",
      },
    },
  },
}

local function config()
  vim.keymap.set('n', '<leader>e', '', { callback = vim.diagnostic.open_float, silent = true })

  vim.fn.sign_define('DiagnosticSignError', { text = '✗', texthl = 'DiagnosticSignError' })
  vim.fn.sign_define('DiagnosticSignWarn', { text = '‼', texthl = 'DiagnosticSignWarn' })
  vim.fn.sign_define('DiagnosticSignInfo', { text = '󱐋', texthl = 'DiagnosticSignInfo' })
  vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
  vim.diagnostic.config {
    underline = true,
    severity_sort = true,
    float = { header = "" },
  }

  local client_capabilities = vim.tbl_deep_extend("force",
    vim.lsp.protocol.make_client_capabilities(),
    -- require('cmp_nvim_lsp').default_capabilities(),
    {}
  )

  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = vim.tbl_keys(servers),
    handlers = {
      function(server)
        require("lspconfig")[server].setup {
          capabilities = client_capabilities,
          settings = servers[server] or {},
        }
      end
    }
  })
end

return {
  "williamboman/mason-lspconfig.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
  },
  config = config,
}
