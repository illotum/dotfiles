" vim: sw=0:ts=4:sts=-1:et:tw=78:fmr={,}:foldlevel=0:fdm=marker:spell
scriptencoding utf-8
" Components {
    call plug#begin('~/.config/nvim/plugged')
    " UI
    Plug 'romainl/flattened'
    Plug 'liuchengxu/vim-which-key'

    " Edit
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-sleuth'
    Plug 'junegunn/vim-easy-align'
    Plug 'sbdchd/neoformat'

    " Navigation
    Plug 'haya14busa/incsearch.vim'
    Plug 'justinmk/vim-sneak'
    Plug 'wellle/targets.vim'
    Plug 'kopischke/vim-stay'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " Git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'rhysd/git-messenger.vim', { 'on': 'GitMessenger' }

    " LSP
    Plug 'neovim/nvim-lsp'
    Plug 'nvim-lua/completion-nvim'
    Plug 'nvim-lua/diagnostic-nvim'

    " Languages
    Plug 'mhinz/vim-mix-format',               { 'for': 'elixir' }
    Plug 'elixir-editors/vim-elixir',          { 'for': 'elixir' }
    Plug 'ElmCast/elm-vim',                    { 'for': 'elm' }
    Plug 'vim-erlang/vim-erlang-runtime',      { 'for': 'erlang' }
    Plug 'vim-erlang/vim-erlang-tags',         { 'for': 'erlang' }
    Plug 'vim-erlang/vim-erlang-omnicomplete', { 'for': 'erlang' }
    Plug 'vim-erlang/vim-erlang-compiler',     { 'for': 'erlang' }
    Plug 'georgewitteman/vim-fish',            { 'for': 'fish' }
    Plug 'sebdah/vim-delve',                   { 'for': 'go' }
    Plug 'JuliaEditorSupport/julia-vim',       { 'for': 'julia' }
    Plug 'mtdl9/vim-log-highlighting',         { 'for': 'log' }
    Plug 'wsdjeg/vim-lua',                     { 'for': 'lua' }
    Plug 'plasticboy/vim-markdown',            { 'for': 'markdown' }
    Plug 'dleonard0/pony-vim-syntax',          { 'for': 'pony' }
    Plug 'rust-lang/rust.vim',                 { 'for': 'rust' }
    Plug 'shmup/vim-sql-syntax',               { 'for': 'sql' }
    Plug 'cespare/vim-toml',                   { 'for': 'toml' }
    Plug 'ziglang/zig.vim',                    { 'for': 'zig' }
    call plug#end()
" }
" General {
    set modeline
    set background=dark           " Assume a dark background
    set clipboard+=unnamedplus    " When possible use + register for copy-paste
    set autowrite                 " Automatically write a file when leaving a modified buffer
    set noswapfile                " Use vcs
    set shortmess+=filmnrxoOtTc   " Abbrev. of messages (avoids 'hit enter')
    set virtualedit=block,onemore " Allow for cursor beyond last character
    set nospell                   " Spell checking off
    set hidden                    " Allow buffer switching without saving
    set visualbell
    set noerrorbells
    set shada="NONE"                       " Don't save ShaDa
    set secure
    set autoread          " Autoload file if it changes on disk

    " Adapt to fish
    if &shell =~# 'fish$'
        set shell=/bin/bash
    endif


    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload

    " Disable providers we do not give a shit about
    let g:loaded_python3_provider = 0
    let g:loaded_python_provider = 0
    let g:loaded_ruby_provider = 0
    let g:loaded_perl_provider = 0
    let g:loaded_node_provider = 0

    " Disable some in built plugins completely
    let g:loaded_netrw            = 1
    let g:loaded_netrwPlugin      = 1
    let g:loaded_matchparen       = 1
    let g:loaded_matchit          = 1
    let g:loaded_2html_plugin     = 1
    let g:loaded_getscriptPlugin  = 1
    let g:loaded_gzip             = 1
    let g:loaded_logipat          = 1
    let g:loaded_rrhelper         = 1
    let g:loaded_spellfile_plugin = 1
    let g:loaded_tarPlugin        = 1
    let g:loaded_vimballPlugin    = 1
    let g:loaded_zipPlugin        = 1
" }
" Vim UI {
    color flattened_dark
    set tabpagemax=15               " Only show 15 tabs
    " set cursorline                  " Highlight current line
    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    highlight clear SpecialKey      " Whitespace should match background
    highlight clear CursorLineNr    " Remove highlight color from current line number

    " Broken down into easily includeable segments
    set laststatus=2
    set statusline=
    set statusline+=%<%f\                              " Filename
    set statusline+=%w%h%m%r%q                         " Options
    set statusline+=%{fugitive#statusline()}           " Git Hotness
    set statusline+=[%{strlen(&fenc)?&fenc:&enc}/%Y] " Filetype
    set statusline+=[%{SleuthIndicator()}]
    set statusline+=%*
    set statusline+=%=%-14.(%l,%c%V%) "\ %p%%" Right aligned file nav info

    set showcmd
    set showmatch                   " Show matching brackets/parenthesis
    set hlsearch                    " Highlight search terms
    set incsearch                   " Don't wait for <cr>
    set inccommand=nosplit          " incremental :s
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set lazyredraw                  " Redraw only when we need to.
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
    set whichwrap=b,s,<,>,[,]       " Backspace and cursor keys wrap too
    set scrolloff=5                 " Minimum lines to keep above and below cursor
    set sidescrolloff=5             " Minimum chars to keep left and right of cursor
    set foldlevelstart=10           " Open most folds by default
    set foldnestmax=3               " 3 nested fold max
    set foldminlines=3              " Do not hide folds shorter than 3
    set foldmethod=indent           " Default fold based on indent level
    set nolist
    set updatetime=100
    set listchars=tab:›\ ,trail:.,extends:#,nbsp:.
    set cmdheight=2
    set signcolumn=yes
" }
" Formatting {
    set nowrap                      " Do not wrap long lines
    set tabstop=4                   " An indentation every four columns
    set shiftwidth=0                " Use indents of 'tabstop' spaces
    set expandtab                   " Tabs are spaces, not tabs
    set softtabstop=-1              " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    set switchbuf=useopen
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    set formatoptions+=o  " Continue comment marker in new lines.
    set formatoptions+=j  " Delete comment character when joining commented lines
    set textwidth=78      " Hard-wrap long lines as you type them.

    augroup fileTypes
        autocmd!
        au FileType fzf set laststatus=0 noshowmode noruler
          \| au BufLeave <buffer> set laststatus=2 showmode ruler
    augroup end

    augroup luaHighlight
        autocmd!
        autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
    augroup END
" }
" Key (re)Mappings {
    " let mapleader = ','
    let mapleader = "\<Space>"
    let maplocalleader = ","

    " Easy command mode
    nmap ; :

    " Easy fold
    nnoremap <Leader><Space> za

    " Easier moving in tabs and windows
    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_
    map <S-H> gT
    map <S-L> gt

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " easy paste multiple lines
    vnoremap <silent> y y`]
    vnoremap <silent> p p`]
    nnoremap <silent> p p`]

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Most prefer to toggle search highlighting rather than clear the current search results.
    nmap <silent> <Leader>/ :set invhlsearch<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection
    vnoremap . :normal .<CR>

    " For when you forget to sudo. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " Easier formatting
    nnoremap <silent> <Leader>tf gwip

    " Error lists
    nnoremap qo :copen<CR>
    nnoremap qc :cclose<CR>
    nnoremap [q :cprevious<CR>
    nnoremap ]q :cnext<CR>
    nnoremap [Q :cfirst<CR>
    nnoremap ]Q :clast<CR>
    nnoremap qs :Grep<SPACE>
    nnoremap q* :Grep <cword><CR>
    nnoremap qt :call ToggleQuickfixList()<CR>
    nnoremap Lo :lopen<CR>
    nnoremap Lc :lclose<CR>
    nnoremap [l :lprevious<CR>
    nnoremap ]l :lnext<CR>
    nnoremap [L :lfirst<CR>
    nnoremap ]L :llast<CR>
    nnoremap Ls :LGrep<SPACE>
    nnoremap L* :LGrep <cword><CR>
    nnoremap Lt :call ToggleLocationList()<CR>

" }
" Plugins {
        " Languages {
            let g:vim_markdown_conceal = 0
        "}
        " neoformat {
            let g:neoformat_enabled_go = ['gofumports', 'goimports', 'gofmt']
            let g:neoformat_basic_format_trim = 1
            augroup fmt
                autocmd!
                autocmd BufWritePre * undojoin | Neoformat
            augroup END
        "}
        " WhichKey {
            let g:mapleader = "\<Space>"
            let g:maplocalleader = ','
            let g:which_key_use_floating_win = 1
            nnoremap <silent> <Leader> :<C-U>WhichKey '<Space>'<CR>
            nnoremap <silent> <LocalLeader> :<C-U>WhichKey ','<CR>
            highlight clear WhichKey
            highlight clear WhichKeyDesc
            highlight clear WhichKeySeperator
            highlight clear WhichKeyGroup
            highlight clear WhichKeyFloating

        "}
        " vim-sneak {
            let g:sneak#label = 1
            let g:sneak#s_next = 1
            let g:sneak#use_ic_scs = 0
        "}
        " incsearch {
            nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>
            let g:incsearch#auto_nohlsearch = 1
            map n  <Plug>(incsearch-nohl-n)
            map N  <Plug>(incsearch-nohl-N)
            map *  <Plug>(incsearch-nohl-*)
            map #  <Plug>(incsearch-nohl-#)
            map g* <Plug>(incsearch-nohl-g*)
            map g# <Plug>(incsearch-nohl-g#)
        "}
        " EasyAlign {
            " Start interactive EasyAlign in visual mode (e.g. vip<Space>ta)
            xmap <Leader>ta <Plug>(EasyAlign)
            " Start interactive EasyAlign for a motion/text object (e.g. <Space>taip)
            nmap <Leader>ta <Plug>(EasyAlign)
        "}
        " FZF {
            let g:fzf_buffers_jump = 1
            let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
              \ 'bg':      ['bg', 'Normal'],
              \ 'hl':      ['fg', 'Comment'],
              \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
              \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
              \ 'hl+':     ['fg', 'Statement'],
              \ 'info':    ['fg', 'PreProc'],
              \ 'border':  ['fg', 'Ignore'],
              \ 'prompt':  ['fg', 'Conditional'],
              \ 'pointer': ['fg', 'Exception'],
              \ 'marker':  ['fg', 'Keyword'],
              \ 'spinner': ['fg', 'Label'],
              \ 'header':  ['fg', 'Comment'] }
            let g:fzf_layout = { 'window': 'enew' }
            let g:fzf_layout = { 'window': '-tabnew' }
            let g:fzf_layout = { 'window': '10split enew' }
            command! -bang -nargs=* Rg
              \ call fzf#vim#grep(
              \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
              \   <bang>0 ? fzf#vim#with_preview('up:60%')
              \           : fzf#vim#with_preview('right:50%:hidden', '?'),
              \   <bang>0)
            " Mapping selecting mappings
            nmap <leader><tab> <plug>(fzf-maps-n)
            xmap <leader><tab> <plug>(fzf-maps-x)
            omap <leader><tab> <plug>(fzf-maps-o)
            " fzf statuslineautocmd! FileType fzf
            nnoremap <silent> <Leader>fh :History<CR>
            nnoremap <silent> <Leader>ff :Files<CR>
            nnoremap <silent> <Leader>bb :Buffers<CR>
            nnoremap <silent> <Leader>fs :Rg<CR>
        " }
        " Fugitive {
            nnoremap <silent> <leader>dh :diffget //2<CR>
            nnoremap <silent> <leader>dl :diffget //3<CR>
            nnoremap <silent> <leader>gs :Gstatus<CR>
            nnoremap <silent> <leader>gd :Gvdiff!<CR>
            nnoremap <silent> <leader>gc :Gcommit<CR>
            nnoremap <silent> <leader>gb :Gblame<CR>
            nnoremap <silent> <leader>gl :Glog<CR>
            nnoremap <silent> <leader>gp :Git push<CR>
            nnoremap <silent> <leader>gr :Gread<CR>
            nnoremap <silent> <leader>gw :Gwrite<CR>
            nnoremap <silent> <leader>ge :Gedit<CR>
            nnoremap <silent> <leader>gi :Git add -p %<CR>
            nnoremap <silent> <leader>gg :SignifyToggle<CR>
        "}
        " completion-nvim {
            let g:completion_auto_change_source = 1
            let g:completion_matching_ignore_case = 1
            set completeopt=menuone,noinsert,noselect
            " Use <Tab> and <S-Tab> to navigate through popup menu
            inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
            inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
            function! s:check_back_space() abort
                let col = col('.') - 1
                return !col || getline('.')[col - 1]  =~ '\s'
            endfunction

            inoremap <silent><expr> <TAB>
              \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<TAB>" :
              \ completion#trigger_completion()
        "}
        " diagnostic-nvim {
            let g:diagnostic_enable_virtual_text = 1
            let g:diagnostic_virtual_text_prefix = ' '
            let g:diagnostic_auto_popup_while_jump = 1
            let g:diagnostic_insert_delay = 1
            let g:diagnostic_show_sign = 1
            call sign_define("LspDiagnosticsErrorSign", {"text" : "⤫", "texthl" : "LspDiagnosticsError"})
            call sign_define("LspDiagnosticsWarningSign", {"text" : "⚠", "texthl" : "LspDiagnosticsWarning"})
            call sign_define("LspDiagnosticInformationSign", {"text" : "I", "texthl" : "LspDiagnosticsInformation"})
            call sign_define("LspDiagnosticHintSign", {"text" : "H", "texthl" : "LspDiagnosticsHint"})
        "}
" }

lua <<EOF
local on_attach_lsp = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    require'completion'.on_attach()
    require'diagnostic'.on_attach()
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
end
require'nvim_lsp'.gopls.setup{on_attach=on_attach_lsp}
EOF

