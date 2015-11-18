"###############################
"#########プラグイン管理########
"###############################

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
"" documantation
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'thinca/vim-ref'
"" editor functions
NeoBundle 'fuenor/im_control.vim'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'tpope/vim-surround'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'rhysd/migemo-search.vim'
NeoBundle 'scrooloose/syntastic'

"" tools
NeoBundle 'Shougo/vimshell'
NeoBundle 'tyru/open-browser.vim' " for previm
"" programing
NeoBundle 'tyru/caw.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'szw/vim-tags'

if has('lua') && (( v:version == 703 && has ('patch885')) || (v:version >= 704))
     NeoBundle 'Shougo/neocomplete'
else
     NeoBundle 'Shougo/neocomplcache'
endif
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'

"" for several languages
NeoBundle 'keith/tmux.vim' " tmux
" ruby
" NeoBundle 'osyo-manga/vim-monster' " <- ruby2.2?
NeoBundle 'tpope/vim-endwise'
NeoBundle 'NigoroJr/rsense' " marcus/rsense has probrem with help
NeoBundle 'supermomonga/neocomplete-rsense.vim'
" haskell
NeoBundle 'eagletmt/ghcmod-vim'
" markdown
NeoBundle 'c01o/previm'
NeoBundle 'yaasita/ore_markdown', { 
      \ 'build' : {
      \     'windows' : 'bundle install --gemfile .\bin\Gemfile',
      \     'mac' : 'bundle install --gemfile ./bin/Gemfile',
      \     'unix' : 'bundle install --gemfile ./bin/Gemfile'
      \    },
      \ }
NeoBundle 'mattn/emmet-vim'

 call neobundle#end()

 " Required:
 filetype plugin indent on

 " If there are uninstalled bundles found on startup,
 " this will conveniently prompt you to install them.
 NeoBundleCheck

"###########
if has("unix")
    "im_control.vim用 fcitx設定
    "日本語入力モードの動作設定
    let IM_CtrlMode = 6
    "日本語入力モード切替を<C-j>で
    inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>

    "<ESC>押下後のIM切り替え開始までの反応が遅い場合はttimeoutlenを短く設定してみてください
    set timeout timeoutlen=300 ttimeoutlen=10
    set statusline+=%{IMStatus('[日本語固定]')}

    " im_control.vimがない環境でもエラーを出さないためのダミー
    function! IMStatus(...)
        return '' 
    endfunction
elseif has("win64")
    if has('gui_running')
        " 「日本語入力固定モード」の動作モード
        let IM_CtrlMode = 4
        " GVimで<C-^>が使える場合の「日本語入力固定モード」切替キー
        inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>
    else
        " 非GUIの場合(この例では「日本語入力固定モード」を無効化している)
        let IM_CtrlMode = 0
    endif
endif


"###############################
"###########基本設定############
"###############################

" vimの外観設定
syntax enable
colorscheme slate
set autoindent
"#tabwidth################
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
"#########################
set showcmd
set showmode
set number
set backspace=indent,eol,start
set encoding=utf-8
set fencs=utf-8,shift-jis,euc-jp,latin1
set ambw=double
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
set statusline=%F%m%r%h%w\%=%y\%{IMStatus('[JP]')}[%{&ff}]\[%{&fenc!=''?&fenc:&enc}]\[%l/%L]
set laststatus=2
":edit等の補完
set wildmode=list,full

augroup MyAutoCmd 
    autocmd! 
    autocmd BufNewFile,BufRead *.{md,mkd,mdn,mdwn,mkdn,mark*} set filetype=markdown  
    autocmd BufNewFile,BufRead *.vimperatorrc set filetype=vimperator
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=gray
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=darkgray
augroup END

" クリップボード連携
set clipboard=unnamedplus,autoselect


"###############################
"########俺マッピング###########
"###############################
command! EditVimrc :edit ~/.vimrc
nnoremap evv :<C-u>EditVimrc<CR>

nnoremap qr :<C-u>QuickRun ruby<CR>

command! Markdown :PrevimOpen
nnoremap qm :<C-u>Markdown<CR>

command! Memo edit ~/Dropbox/memo/memo.md
nnoremap mm :<C-u>Memo<CR>
command! -nargs=1 -complete=filetype Tmp edit ~/.vim_tmp/tmp.<args>
command! -nargs=1 -complete=filetype Temp edit ~/.vim_tmp/tmp.<args>

command! Haskell :QuickRun haskell
nnoremap qh :<C-u>Haskell<CR>

nnoremap <C-h><C-h> :<C-u>help<Space>
nnoremap <C-h><C-r> :<C-u>Ref refe 

nnoremap tgg :<C-u>TagsGenerate!<CR>

nnoremap k gk
nnoremap j gj
vnoremap k gk
vnoremap j gj
nnoremap <C-p> gT
nnoremap <C-n> gt
"foolproof
nnoremap ZQ <Nop>

" \cで行の先頭にコメントをつけたり外したりできる
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" C-kでNeoSnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

"###############################
"###########検索設定############
"###############################
"検索は基本大文字小文字無視、大文字があるときのみ区別
set incsearch
set hlsearch
set ignorecase
set smartcase
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
"検索をループさせる
set wrapscan

" migemo-search.vim有効化
if executable('cmigemo')
    cnoremap <expr><CR> migemosearch#replace_search_word()."\<CR>"
endif

" Use RSence to omnicompletion
let g:rsenseUseOmniFunc = 1


"###############################
"##########その他設定###########
"###############################

"vim-indent-color
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
let g:indent_guides_color_change_percent = 10
let g:indent_guides_guide_size = 1

" Use neocomplete.vim
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#omni#input_patterns = {
\   "ruby" : '[^. *\t]\.\w*\|\h\w*::',
\}
" <TAB> completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" rubocop static code analyzer on save
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
