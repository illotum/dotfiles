" vim: sw=0 ts=4 sts=-1 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
scriptencoding utf-8
" Components {
    call plug#begin('~/.config/nvim/plugged')
    Plug 'altercation/vim-colors-solarized'
    Plug 'romainl/flattened'
    Plug 'sjl/splice.vim'

    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'junegunn/vim-easy-align'
    Plug 'Lokaltog/vim-easymotion'
    Plug 'majutsushi/tagbar'
    Plug 'kopischke/vim-stay'
    Plug 'w0rp/ale'

    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

    Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
    Plug 'dag/vim-fish', { 'for': 'fish' }
    Plug 'dleonard0/pony-vim-syntax', { 'for': 'pony' }
    Plug 'b4b4r07/vim-hcl', { 'for': 'hcl' }
    Plug 'fatih/vim-hclfmt', { 'for': 'hcl' }
    Plug 'cespare/vim-toml', { 'for': 'toml' }
    Plug 'ziglang/zig.vim', { 'for': 'zig' }
    Plug 'mhinz/vim-mix-format', { 'for': 'elixir' }
    Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }
    Plug 'vim-erlang/vim-erlang-runtime', { 'for': 'erlang' }
    Plug 'calviken/vim-gdscript3'
    Plug 'JuliaEditorSupport/julia-vim', { 'for': 'julia' }

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
    set spell                     " Spell checking on
    set hidden                    " Allow buffer switching without saving
    set visualbell
    set noerrorbells


    " Restore cursor to file position in previous editing session
    function! ResCur()
        if line("'\"") <= line('$')
            normal! g`"
            return 1
        endif
    endfunction

    augroup resCur
        autocmd!
        autocmd BufWinEnter * call ResCur()
    augroup END

    " Adapt to fish
    if &shell =~# 'fish$'
        set shell=/bin/bash
    endif


    " Setting up the directories {
    if has('persistent_undo')
        set undofile                " So is persistent undo ...
        set undolevels=1000         " Maximum number of changes that can be undone
        set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
    endif
    " }
" }
" Vim UI {
    color solarized
    set title
    set tabpagemax=15               " Only show 15 tabs
    " set cursorline                  " Highlight current line
    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    highlight clear SpecialKey      " Whitespace should match background
    highlight clear CursorLineNr    " Remove highlight color from current line number

    " Broken down into easily includeable segments
    set laststatus=2
    set statusline=
    set statusline+=%<%f\                               " Filename
    set statusline+=%w%h%m%r%q                         " Options
    set statusline+=%{fugitive#statusline()}           " Git Hotness
    set statusline+=\ [%{strlen(&fenc)?&fenc:&enc}/%Y] " Filetype
    set statusline+=\ [%{LinterStatus()}]
    set statusline+=%*
    set statusline+=%=%-14.(%l,%c%V%) "\ %p%%" Right aligned file nav info

    set nonumber                      " Line numbers off
    " set relativenumber              " Numbers relative to current position
    set showcmd
    set showmatch                   " Show matching brackets/parenthesis
    set hlsearch                    " Highlight search terms
    set incsearch
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set gdefault
    set lazyredraw                  " Redraw only when we need to.
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
    set whichwrap=b,s,<,>,[,]       " Backspace and cursor keys wrap too
    set scrolloff=5                 " Minimum lines to keep above and below cursor
    set sidescrolloff=5             " Minimum chars to keep left and right of cursor
    set foldlevelstart=10           " Open most folds by default
    set foldnestmax=10              " 10 nested fold max
    set foldminlines=5              " Do not hide folds shorter than 5
    set foldmethod=indent           " Default fold based on indent level
    set nolist
    set updatetime=300
    " set list                        " Highlight problematic whitespace
    " set listchars=tab:›\ ,trail:.,extends:#,nbsp:.
" }
" Formatting {
    set nowrap                      " Do not wrap long lines
    set tabstop=2                   " An indentation every four columns
    set shiftwidth=0                " Use indents of 'tabstop' spaces
    set expandtab                   " Tabs are spaces, not tabs
    set softtabstop=-1              " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    " set colorcolumn=72
    " set textwidth=72

    augroup fileTypes
        autocmd!
        au FileType json syntax match Comment +\/\/.\+$+
        au FileType go,vim setlocal tabstop=4
        " au FileType erlang setlocal tabstop=4 noexpandtab
        au FileType vim autocmd BufWritePre <buffer> call StripTrailingWhitespace()
        au FileType fzf set laststatus=0 noshowmode noruler
          \| au BufLeave <buffer> set laststatus=2 showmode ruler
        " Instead of reverting the cursor to the last position in the buffer, we
        " set it to the first line when editing a git commit message
        au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    augroup end
" }
" Key (re)Mappings {
    let mapleader = ','
    let maplocalleader = '_'

    " Easy command mode
    nmap ; :

    " Easy fold
    nnoremap <Space> za

    " Easy scroll
    " nnoremap <Space> <C-D>
    " vnoremap <Space> <C-D>
    " nnoremap <Tab> <C-U>
    " vnoremap <Tab> <C-U>

    " Easy join
    " nnoremap K i<CR><Esc>

    " Easier moving in tabs and windows
    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " highlight last inserted text
    nnoremap gV `[v`]

    " easy paste multiple lines
    vnoremap <silent> y y`]
    vnoremap <silent> p p`]
    nnoremap <silent> p p`]

    " The following two lines conflict with moving to top and
    " bottom of the screen
    map <S-H> gT
    map <S-L> gt

    " Stupid shift key fixes
    if has('user_commands')
        command! -bang -nargs=* -complete=file E e<bang> <args>
        command! -bang -nargs=* -complete=file W w<bang> <args>
        command! -bang -nargs=* -complete=file Wq wq<bang> <args>
        command! -bang -nargs=* -complete=file WQ wq<bang> <args>
        command! -bang Wa wa<bang>
        command! -bang WA wa<bang>
        command! -bang Q q<bang>
        command! -bang QA qa<bang>
        command! -bang Qa qa<bang>
    endif
    cmap Tabe tabe

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

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " For when you forget to sudo. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Display all lines with keyword under cursor and ask which one to jump to
    " nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " Easier formatting
    nnoremap <silent> <Leader>xf gwip

    " Error lists
    nnoremap <leader>ec :cclose<CR>
" }
" Plugins {
    let b:match_ignorecase = 1
    let g:mix_format_on_save = 1
    " Tagbar {
        nmap <Leader>tt :TagbarOpenAutoClose<CR>
        let g:tagbar_left = 1
        let g:tagbar_sort = 0
        let g:tagbar_compact = 1


        let g:tagbar_type_markdown = {
                \ 'ctagstype' : 'markdown',
                \ 'kinds' : [
                        \ 'h:headings',
                \ ],
            \ 'sort' : 0
            \ }
    "}
    " Easymotion {
        let g:EasyMotion_do_mapping = 0 " Disable default mappings
        let g:EasyMotion_smartcase = 1  " Turn on case sensitive feature
        "nmap s <Plug>(easymotion-s)
        nmap s <Plug>(easymotion-s2)
        map <Leader>j <Plug>(easymotion-j)
        map <Leader>k <Plug>(easymotion-k)
    "}
    " EasyAlign {
        " Start interactive EasyAlign in visual mode (e.g. vip<Space>ta)
        xmap <Leader>xa <Plug>(EasyAlign)
        " Start interactive EasyAlign for a motion/text object (e.g. <Space>taip)
        nmap <Leader>xa <Plug>(EasyAlign)
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
        nnoremap <silent> gf :History<CR>
        nnoremap <silent> <Leader>ff :Files<CR>
        nnoremap <silent> <Leader>bb :Buffers<CR>
        nnoremap <silent> <Leader>fs :Rg<CR>
    " }
    " Fugitive {
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> <leader>gr :Gread<CR>
        nnoremap <silent> <leader>gw :Gwrite<CR>
        nnoremap <silent> <leader>ge :Gedit<CR>
        " Mnemonic _i_nteractive
        nnoremap <silent> <leader>gi :Git add -p %<CR>
        nnoremap <silent> <leader>gg :SignifyToggle<CR>
    "}
    " ALE {
        " Error and warning signs.
        let g:ale_sign_error = '⤫'
        let g:ale_sign_warning = '⚠'
        let g:ale_echo_msg_error_str = 'E'
        let g:ale_echo_msg_warning_str = 'W'
        let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
        let g:ale_set_loclist = 0
        let g:ale_set_quickfix = 0
        let g:ale_sign_column_always = 1
        call ale#linter#Define('go', {
            \   'name': 'revive',
            \   'output_stream': 'both',
            \   'executable': 'revive',
            \   'read_buffer': 0,
            \   'command': 'revive -config ~/.revive.toml %t',
            \   'callback': 'ale#handlers#unix#HandleAsWarning',
            \})
        call ale#linter#Define('rust', {
            \   'name': 'clippy',
            \   'output_stream': 'both',
            \   'executable': 'cargo',
            \   'read_buffer': 0,
            \   'command': 'cargo clippy',
            \   'callback': 'ale#handlers#unix#HandleAsWarning',
            \})
        let g:ale_linters = {'go': ['revive'], 'rust': ['clippy']}
        nmap <Leader>en <Plug>(ale_previous_wrap)
        nmap <Leader>ep <Plug>(ale_next_wrap)
        function! LinterStatus() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            let l:all_errors = l:counts.error + l:counts.style_error
            let l:all_non_errors = l:counts.total - l:all_errors
            return l:counts.total == 0 ? 'OK' : printf(
            \   '%dW %dE',
            \   l:all_non_errors,
            \   l:all_errors
            \)
        endfunction
    "}
    " CoC {
        inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

        function! s:check_back_space() abort
          let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
        endfunction
        inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

        " Use `[c` and `]c` for navigate diagnostics
        nmap <silent> [c <Plug>(coc-diagnostic-prev)
        nmap <silent> ]c <Plug>(coc-diagnostic-next)

        " Remap keys for gotos
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

        " Use K for show documentation in preview window
        nnoremap <silent> K :call <SID>show_documentation()<CR>

        function! s:show_documentation()
          if &filetype ==# 'vim'
            execute 'h '.expand('<cword>')
          else
            call CocAction('doHover')
          endif
        endfunction

        " Highlight symbol under cursor on CursorHold
        " autocmd CursorHold * silent call CocActionAsync('highlight')

        " Remap for rename current word
        nmap <leader>rn <Plug>(coc-rename)

        " Remap for format selected region
        vmap <leader>f  <Plug>(coc-format-selected)
        nmap <leader>f  <Plug>(coc-format-selected)

        augroup mygroup
          autocmd!
          " Setup formatexpr specified filetype(s).
          autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
          " Update signature help on jump placeholder
          autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end

        " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
        vmap <leader>a  <Plug>(coc-codeaction-selected)
        nmap <leader>a  <Plug>(coc-codeaction-selected)

        " Remap for do codeAction of current line
        nmap <leader>ac  <Plug>(coc-codeaction)
        " Fix autofix problem of current line
        nmap <leader>qf  <Plug>(coc-fix-current)

        " Use `:Format` for format current buffer
        command! -nargs=0 Format :call CocAction('format')

        " Use `:Fold` for fold current buffer
        command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " }
" }
" Functions {
    " Initialize directories {
    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        let common_dir = parent . '/.' . prefix

        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists('*mkdir')
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo 'Warning: Unable to create backup directory: ' . directory
                echo 'Try: mkdir -p ' . directory
            else
                let directory = substitute(directory, ' ', '\\\\ ', 'g')
                exec 'set ' . settingname . '=' . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
    " }

    " Strip whitespace {
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line('.')
        let c = col('.')
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    " }
" }
