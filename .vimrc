"###############################
"#########プラグイン管理########
"###############################

if has('vim_starting')
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
      echo "install neobundle..."
          :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
            endif
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" add plugin
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'tyru/caw.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'fuenor/im_control.vim'
NeoBundle 'rhysd/migemo-search.vim'
NeoBundle 'VimRepress'
NeoBundle 'Shougo/vimshell'
" vimproc is needed for vimshell
NeoBundle 'Shougo/vimproc.vim', { 
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
" openbrowser.vim is now for only previm
NeoBundle 'c01o/previm' " :PrevimOpen only works in filetype=markdown
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'yaasita/ore_markdown', {
      \ 'build' : {
      \     'windows' : 'bundle install --gemfile .\bin\Gemfile',
      \     'mac' : 'bundle install --gemfile ./bin/Gemfile',
      \     'unix' : 'bundle install --gemfile ./bin/Gemfile'
      \    },
      \ }
NeoBundle 'tpope/vim-surround'
NeoBundle 'Keithbsmiley/tmux.vim'
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'nathanaelkane/vim-indent-guides'

" NeoComplete
if has('lua') && (( v:version == 703 && has ('patch885')) || (v:version >= 704))
     NeoBundle 'Shougo/neocomplete'
else
     NeoBundle 'Shougo/neocomplcache'
endif
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'

NeoBundleCheck
call neobundle#end()

filetype plugin on
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
filetype plugin indent on
syntax enable
colorscheme slate
set nocompatible
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
nnoremap evv :EditVimrc<CR>

nnoremap qr :QuickRun ruby<CR>
nnoremap <C-h><C-r> :Ref refe 

command! Markdown :PrevimOpen
nnoremap md :Markdown<CR>    "oldstyle markdown shortcut
nnoremap qm :Markdown<CR>    "unify Quickrun-shortcuts "qX"

command! Memo edit ~/Dropbox/memo/memo.md
nnoremap mm :Memo<CR>
command! -nargs=1 -complete=filetype Tmp edit ~/.vim_tmp/tmp.<args>
command! -nargs=1 -complete=filetype Temp edit ~/.vim_tmp/tmp.<args>

command! Haskell :QuickRun haskell
nnoremap qh :Haskell<CR>    "unify Quickrun-shortcuts "qX"

nnoremap <C-h><C-h> :<C-u>help<Space>

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

"vim-indent-color
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
let g:indent_guides_color_change_percent = 10
let g:indent_guides_guide_size = 1

