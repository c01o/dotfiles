"###############################
"#########プラグイン管理########
"###############################
" Flags
let s:use_dein = 1

" vi compatibility
if !&compatible
  set nocompatible
endif

" Prepare .vim dir
let s:vimdir = $HOME . "/.vim"
if has("vim_starting")
  if ! isdirectory(s:vimdir)
    call system("mkdir " . s:vimdir)
  endif
endif

" dein
let s:dein_enabled  = 0
if s:use_dein && v:version >= 704
  let s:dein_enabled = 1

  " Set dein paths
  let s:dein_dir = s:vimdir . '/dein'
  let s:dein_github = s:dein_dir . '/repos/github.com'
  let s:dein_repo_name = "Shougo/dein.vim"
  let s:dein_repo_dir = s:dein_github . '/' . s:dein_repo_name

  " Check dein has been installed or not.
  if !isdirectory(s:dein_repo_dir)
    echo "dein is not installed, install now "
    let s:dein_repo = "https://github.com/" . s:dein_repo_name
    echo "git clone " . s:dein_repo . " " . s:dein_repo_dir
    call system("git clone " . s:dein_repo . " " . s:dein_repo_dir)
  endif
  let &runtimepath = &runtimepath . "," . s:dein_repo_dir

  " Check cache
  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    """""""""""""""""""""""
    "" plugin management ""
    """""""""""""""""""""""
    call dein#add('Shougo/dein.vim')

    " documantation
    call dein#add('vim-jp/vimdoc-ja')
    call dein#add('thinca/vim-ref')

    " editor functions
    "" core util
    call dein#add('Shougo/vimproc', {'build': 'make'})
    "" input support
    call dein#add('fuenor/im_control.vim')
    call dein#add('jiangmiao/auto-pairs')
    call dein#add('tpope/vim-surround')
    call dein#add('tpope/vim-repeat')
    call dein#add('tyru/caw.vim')
    "" looks
    call dein#add('nathanaelkane/vim-indent-guides')
    "" search
    call dein#add('rhysd/migemo-search.vim')

    " programming support
    "" test run
    call dein#add('tyru/open-browser.vim', {'depends': ['Shougo/vimproc']})
    call dein#add('thinca/vim-quickrun',   {'depends': ['tyru/open-browser.vim']})
    "" syntax check
    call dein#add('scrooloose/syntastic')
    "" enable smart tag-jump
    call dein#add('szw/vim-tags')
    "" snippet
    call dein#add('Shougo/neosnippet', {'depends': ['neosnippet.vim']})
    call dein#add('Shougo/neosnippet-snippets', {'depends': ['neosnippet.vim']})
    call dein#add('honza/vim-snippets', {'depends': ['neosnippet.vim']})
    "" auto complete
    if has('nvim')
      call dein#add('Shougo/deoplete.nvim', {'on_i': 1, 'lazy': 1})
      call dein#add('ujihisa/neco-look', {'depends': ['deoplete.vim']})
      call dein#add('zchee/deoplete-jedi', {'depends': ['deoplete.vim']})
    elseif has('lua') && (( v:version == 703 && has ('patch885')) || (v:version >= 704))
      call dein#add('Shougo/neocomplete.vim', {'on_i': 1, 'lazy': 1})
      call dein#add('ujihisa/neco-look', {'depends': ['neocomplete.vim']})
    endif
    "" specific language supports
    """ zen-coding
    call dein#add('mattn/emmet-vim', {'on_ft': ['ruby', 'html', 'css', 'markdown', 'eruby']})
    """ ruby
    call dein#add('tpope/vim-endwise', {'on_ft': ['ruby']})
    call dein#add('NigoroJr/rsense', {'on_ft': ['ruby']})
    " this plugin seems dead
    "call dein#add('supermomonga/neocomplete-rsense.vim', {'on_ft': ['ruby'], 'depends': ['neocomplete.vim']}) 
    """ python
    call dein#add('davidhalter/jedi-vim', {'on_ft': ['python']})
    """ haskell
    call dein#add('eagletmt/ghcmod-vim', {'on_ft': ['haskell']})
    """ markdown
    call dein#add('c01o/previm', {'on_ft': ['markdown']})
    call dein#add('yaasita/ore_markdown', {
          \ 'on_ft': ['markdown'],
          \ 'build': 'bundle install --gemfile ./bin/Gemfile'
          \ })
    """ .tmux.conf
    call dein#add('keith/tmux.vim', {'on_ft': ['tmux']})

    call dein#end()
    call dein#save_state()
  endif


  " Installation check.
  if dein#check_install()
    call dein#install()
  endif
endif

filetype plugin indent on

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
set ambw=double
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
set statusline=%F%m%r%h%w\%=%y\%{IMStatus('[JP]')}[%{&ff}]\[%{&fenc!=''?&fenc:&enc}]\[%l/%L]
set laststatus=2

":edit等の補完
set wildmode=list,full
set encoding=utf-8
set fencs=utf-8,shift-jis,euc-jp,latin1

augroup MyAutoCmd 
  autocmd! 
  autocmd BufNewFile,BufRead *.{md,mkd,mdn,mdwn,mkdn,mark*} set filetype=markdown  
  autocmd BufNewFile,BufRead *.vimperatorrc set filetype=vimperator
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=gray
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=darkgray
augroup END

" クリップボード連携
set clipboard+=unnamedplus



"###############################
"########俺マッピング###########
"###############################
command! EditVimrc :edit ~/.vimrc
nnoremap evv :<C-u>EditVimrc<CR>

" quickrun
nnoremap qr :<C-u>QuickRun ruby<CR>
nnoremap qp :<C-u>QuickRun python<CR>

command! Markdown :PrevimOpen
nnoremap qm :<C-u>Markdown<CR>

command! Haskell :QuickRun haskell
nnoremap qh :<C-u>Haskell<CR>

" help/documents
nnoremap <C-h><C-h> :<C-u>help 
nnoremap <C-h><C-r> :<C-u>Ref refe 
nnoremap <C-h><C-p> :<C-u>Ref pydoc 


" basic commands remapping
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

" tggでジャンプ用タグ生成
nnoremap tgg :<C-u>TagsGenerate!<CR>

" C-kでNeoSnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" memo
command! Memo edit ~/Dropbox/memo/memo.md
nnoremap mm :<C-u>Memo<CR>
command! -nargs=1 -complete=filetype Tmp edit ~/.vim_tmp/tmp.<args>
command! -nargs=1 -complete=filetype Temp edit ~/.vim_tmp/tmp.<args>

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
"###########補完設定############
"###############################
" Deoplete/Neocomplete
if has('nvim') && has('python3')
  let g:acp_enableAtStartup = 0
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_smart_case = 1
  let g:deoplete#sources#omni#input_patterns = {
        \   "ruby" : '[^. *\t]\.\w*\|\h\w*::',
        \}

  " use jedi(python code-complete plugin) in deoplete
  " thanks to deoplete source plugin 'zchee/deoplete-jedi'
  " the following configs are equal to plugin's default ones
  "g:deoplete#sources#jedi#statement_length = 50
  "g:deoplete#sources#jedi#enable_cache = 1
  "g:deoplete#sources#jedi#show_docstring = 0

  " <TAB> completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  deoplete#mappings#close_popup()
  inoremap <expr><C-e>  deoplete#mappings#cancel_popup()
else
  " use neocomplete
  let g:acp_enableAtStartup = 0
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#sources#omni#input_patterns = {
        \   "ruby" : '[^. *\t]\.\w*\|\h\w*::',
        \}

  " use jedi(python code-complete plugin) in neocomplete
  autocmd FileType python setlocal omnifunc=jedi#completions
  let g:jedi#auto_vim_configuration = 0

  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif

  let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

  " <TAB> completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e>  neocomplete#cancel_popup()
endif

" neosnippet
"" use honza/vim-snippets from neosnippet
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory=s:dein_github . '/vim-snippets/snippets'

"###############################
"##########その他設定###########
"###############################

"vim-indent-color
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
let g:indent_guides_color_change_percent = 10
let g:indent_guides_guide_size = 1

" rubocop static code analyzer on save
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }

" erb-style surroundings
" thanks to:
" https://github.com/tpope/vim-rails/issues/245
let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"
