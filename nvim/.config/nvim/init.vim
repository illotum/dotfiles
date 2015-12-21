" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:

" Components {
    call plug#begin('~/.config/nvim/plugged')

    Plug 'junegunn/seoul256.vim'
    Plug 'junegunn/vim-easy-align'
    Plug 'altercation/vim-colors-solarized'
    Plug 'ap/vim-css-color'

    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-surround'

    Plug 'Lokaltog/vim-easymotion'
    " Plug 'kien/ctrlp.vim'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'benekastah/neomake'
    Plug 'majutsushi/tagbar'
    Plug 'Konfekt/FastFold'
    Plug 'kopischke/vim-stay'

    Plug 'luochen1990/rainbow', { 'for': 'clojure' }
    Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
    Plug 'guns/vim-sexp', { 'for': 'clojure' }
    Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }

    Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
    Plug 'Twinside/vim-hoogle', { 'for': 'haskell' }
    " Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
    Plug 'dag/vim2hs', { 'for': 'haskell' }

    Plug 'fatih/vim-go', { 'for': 'go' }
    Plug 'zchee/deoplete-go', { 'for': 'go' }
    " Plug 'racer-rust/vim-racer' { 'for': 'rust'}
    Plug 'klen/python-mode', { 'for': 'python' }
    Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
    Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
    Plug 'cespare/vim-toml', { 'for': 'toml' }
    Plug 'dag/vim-fish', { 'for': 'fish' }
    Plug 'Shougo/neco-vim', { 'for': 'vim' }

    Plug 'Shougo/deoplete.nvim'
    Plug 'Shougo/neco-syntax'
    " Plug 'Shougo/neosnippet.vim'

    call plug#end()
" }

" General {
    set modeline
    set background=dark         " Assume a dark background
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    if has('clipboard')
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamedplus
        else         " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif

    set autowrite                       " Automatically write a file when leaving a modified buffer
    set nobackup                        " Use vcs
    set noswapfile                      " Use vcs
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set spell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving
    set visualbell
    set noerrorbells

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    " Restore cursor to file position in previous editing session
    function! ResCur()
        if line("'\"") <= line("$")
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
        set shell=/bin/sh
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
    set showmode                    " Display the current mode

    set cursorline                  " Highlight current line
    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    highlight clear SpecialKey      " Whitespace should match background
    highlight clear CursorLineNr    " Remove highlight color from current line number
    "let g:CSApprox_hook_post = ['hi clear SignColumn']

    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids

    if has('statusline')
        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=%{fugitive#statusline()} " Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set relativenumber              " Numbers relative to current position
    set showmatch                   " Show matching brackets/parenthesis
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Visual autocomplete for command menu
    set lazyredraw                  " Redraw only when we need to.
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=1                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set sidescrolloff=5             " Minimum chars to keep left and right of cursor
    set foldenable                  " Auto fold code
    set foldlevelstart=10           " Open most folds by default
    set foldnestmax=10              " 10 nested fold max
    set foldmethod=indent           " Default fold based on indent level
    set list
    set listchars=tab:›\ ,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
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
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks

    " Remove trailing whitespaces and ^M chars
    autocmd FileType javascript,python,ruby,clojure,xml,yml,coffee,haskell,go autocmd BufWritePre <buffer> call StripTrailingWhitespace()
    autocmd FileType haskell,ruby,clojure,coffee,javascript setlocal tabstop=2 shiftwidth=2
" }

" Key (re)Mappings {

    let mapleader = ','
    let maplocalleader = '_'

    " Easy command mode
    nmap ; :

    " Easy fold
    nnoremap <Space> za

    " Easy join
    nnoremap K i<CR><Esc>

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

    " End/Start of line motion keys act relative to row/wrap width in the
    " presence of `:set wrap`, and relative to line for `:set nowrap`.
    " Default vim behaviour is to act relative to text line in both cases
    "
    function! WrapRelativeMotion(key, ...) " Same for 0, home, end, etc
        let vis_sel=""
        if a:0
            let vis_sel="gv"
        endif
        if &wrap
            execute "normal!" vis_sel . "g" . a:key
        else
            execute "normal!" vis_sel . a:key
        endif
    endfunction

    " Map g* keys in Normal, Operator-pending, and Visual+select
    noremap $ :call WrapRelativeMotion("$")<CR>
    noremap <End> :call WrapRelativeMotion("$")<CR>
    noremap 0 :call WrapRelativeMotion("0")<CR>
    noremap <Home> :call WrapRelativeMotion("0")<CR>
    noremap ^ :call WrapRelativeMotion("^")<CR>
    " Overwrite the operator pending $/<End> mappings from above
    " to force inclusive motion with :execute normal!
    onoremap $ v:call WrapRelativeMotion("$")<CR>
    onoremap <End> v:call WrapRelativeMotion("$")<CR>
    " Overwrite the Visual+select mode mappings from above
    " to ensure the correct vis_sel flag is passed to function
    vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
    vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
    vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
    vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
    vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>

    " The following two lines conflict with moving to top and
    " bottom of the screen
    map <S-H> gT
    map <S-L> gt

    " Stupid shift key fixes
    if has("user_commands")
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

    " Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    " Most prefer to toggle search highlighting rather than clear the current
    " search results. To clear search highlighting rather than toggle it on
    " and off, add the following to your .vimrc.before.local file:
    "   let g:spf13_clear_search_highlight = 1
    nmap <silent> <leader>/ :set invhlsearch<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=expand('%:h').'/'<cr>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Map <Leader>ff to display all lines with keyword under cursor
    " and ask which one to jump to
    nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " Easier formatting
    nnoremap <silent> <leader>q gwip

" }

" Plugins {

    " Misc {
        let b:match_ignorecase = 1 " matchit.vim
    " }

    " Easymotion {

        let g:EasyMotion_do_mapping = 0 " Disable default mappings

        " Bi-directional find motion
        " Jump to anywhere you want with minimal keystrokes, with just one key binding.
        " `s{char}{label}`
        "nmap s <Plug>(easymotion-s)
        " or
        " `s{char}{char}{label}`
        " Need one more keystroke, but on average, it may be more comfortable.
        nmap s <Plug>(easymotion-s2)

        " Turn on case sensitive feature
        let g:EasyMotion_smartcase = 1

        " JK motions: Line motions
        map <Leader>j <Plug>(easymotion-j)
        map <Leader>k <Plug>(easymotion-k)

    " }

    " EasyAlign {
    " Start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)

    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)
"}

    " PyMode {
        let g:pymode_lint_checker = "pyflakes"
        let g:pymode_utils_whitespaces = 0
        let g:pymode_options = 0
        if !has('python')
            let g:pymode = 0
        endif
    " }

    "" ctrlp {
    "    let g:ctrlp_working_path_mode = 'ra'
    "    let g:ctrlp_match_window = 'bottom,order:ttb'
    "    nnoremap <silent> <D-t> :CtrlP<CR>
    "    nnoremap <silent> <D-r> :CtrlPMRU<CR>
    "    nnoremap <silent> <c-t> :CtrlPBufTag<CR>
    "    let g:ctrlp_custom_ignore = {
    "      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    "      \ 'file': '\v\.(exe|so|dll|pyc|o)$',
    "      \ }

    "    if executable('ag')
    "        let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
    "    elseif executable('ack')
    "        let s:ctrlp_fallback = 'ack %s --nocolor -f'
    "    else
    "        let s:ctrlp_fallback = 'find %s -type f'
    "    endif

    "    let g:ctrlp_user_command = {
    "        \ 'types': {
    "            \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
    "            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    "        \ },
    "        \ 'fallback': s:ctrlp_fallback
    "    \ }
    ""}

    " fzf {
    " This is the default extra key bindings
    let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

    " Default fzf layout
    " - down / up / left / right
    " - window (nvim only)
    let g:fzf_layout = { 'down': '~40%' }

    " Advanced customization using autoload functions
    autocmd VimEnter * command! Colors
      \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'})

    " Mapping selecting mappings
    nmap <leader><tab> <plug>(fzf-maps-n)
    xmap <leader><tab> <plug>(fzf-maps-x)
    omap <leader><tab> <plug>(fzf-maps-o)

    " Ctrl-P
    nnoremap <silent> <c-p> :Files<CR>

    "}

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

    " UndoTree {
        nnoremap <Leader>u :UndotreeToggle<CR>
        " If undotree is opened, it is likely one wants to interact with it.
        let g:undotree_SetFocusWhenToggle=1
    " }

    " Syntastic {
        let g:syntastic_python_pylint_args="--disable=C,R0903,R0904,W0232"
        let g:syntastic_error_symbol = "✗"
        let g:syntastic_warning_symbol = "⚠"
        map <silent> <Leader>e :Errors<CR>

        autocmd! BufWritePost * Neomake
" }

    " GHC-Mod {
        au FileType haskell nnoremap <buffer> tt :GhcModType<CR>
        au FileType haskell nnoremap <buffer> <silent> <leader>tt :GhcModTypeClear<CR>
        au FileType haskell nnoremap <buffer> ti :GhcModInfo<CR>
        au FileType haskell nnoremap <buffer> <silent> tc :GhcModCheckAndLintAsync<CR>
        au FileType haskell nnoremap <buffer> <silent> <leader>tc :cclose<CR>
" }

    " vim-hoogle {
        au FileType haskell nnoremap <buffer> ts :Hoogle
        au FileType haskell nnoremap <buffer> <leader>ts :HoogleClose<CR>
    " }

    " vim-go {
    au FileType go nmap <leader>r <Plug>(go-run)
    au FileType go nmap <leader>b <Plug>(go-build)
    au FileType go nmap <leader>t <Plug>(go-test)
    au FileType go nmap <leader>c <Plug>(go-coverage)
    au FileType go nmap <Leader>ds <Plug>(go-def-split)
    au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
    au FileType go nmap <Leader>dt <Plug>(go-def-tab)
    au FileType go nmap <Leader>gd <Plug>(go-doc)
    au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
    au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
    au FileType go nmap <Leader>s <Plug>(go-implements)
    au FileType go nmap <Leader>i <Plug>(go-info)
    au FileType go nmap <Leader>e <Plug>(go-rename)
    au FileType go set fdm=syntax

    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1
    let g:go_fmt_fail_silently = 1
    let g:go_fmt_command = "goimports"
    " }

    " Rainbow {
    let g:rainbow_active = 1
    let g:rainbow_conf = {
        \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
        \   'ctermfgs': ['blue', 'yellow', 'cyan', 'magenta'],
        \}
    " }

    " Deoplete {
    set completeopt+=noinsert,noselect
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_smart_case = 1

    let g:deoplete#sources#go = 'vim-go'
    " autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
    let g:deoplete#omni_patterns = {}
    let g:deoplete#omni_patterns.ruby = ['[^. *\t]\.\w*', '\h\w*::']
    let g:deoplete#sources = {}
    let g:deoplete#sources._ = ['omni', 'buffer', 'tag']

    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
    inoremap <expr><BS>  deoplete#mappings#smart_close_popup()."\<C-h>"

    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return deoplete#mappings#close_popup() . "\<CR>"
    endfunction
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
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
    " }

    " Strip whitespace {
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    " }

    " Shell command {
    function! s:RunShellCommand(cmdline)
        botright new

        setlocal buftype=nofile
        setlocal bufhidden=delete
        setlocal nobuflisted
        setlocal noswapfile
        setlocal nowrap
        setlocal filetype=shell
        setlocal syntax=shell

        call setline(1, a:cmdline)
        call setline(2, substitute(a:cmdline, '.', '=', 'g'))
        execute 'silent $read !' . escape(a:cmdline, '%#')
        setlocal nomodifiable
        1
    endfunction

    command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
    " e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
    " }

" }

