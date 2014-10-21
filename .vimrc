"###############################
"#########プラグイン管理########
"###############################

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" add plugin
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'tyru/caw.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'fuenor/im_control.vim'
NeoBundle 'rhysd/migemo-search.vim'
NeoBundle 'VimRepress'
NeoBundle 'Shougo/vimshell'
" vimproc is needed for vimshell
NeoBundle 'Shougo/vimproc.vim', { 
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
"openbrowser.vim is now for only previm
NeoBundle 'kannokanno/previm' " :PrevimOpen only works in filetype=markdown
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tpope/vim-surround'

filetype plugin on
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

"############


"###############################
"###########基本設定############
"###############################

" vimの外観設定
set nocompatible
set autoindent
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
augroup

" クリップボード連携
set clipboard=unnamed,autoselect

" \cで行の先頭にコメントをつけたり外したりできる
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)


"###############################
"########俺マッピング###########
"###############################
command! EditVimrc :edit ~/.vimrc
nnoremap evv :EditVimrc<CR>

nnoremap qr :QuickRun ruby<CR>

command! Markdown :QuickRun markdown
nnoremap md :Markdown<CR>	"oldstyle markdown shortcut
nnoremap qm :Markdown<CR>	"unify Quickrun-shortcuts "qX"

command! Memo edit ~/Dropbox/memo/memo.md
nnoremap mm :Memo<CR>
command! -nargs=1 -complete=filetype Tmp edit ~/.vim_tmp/tmp.<args>
command! -nargs=1 -complete=filetype Temp edit ~/.vim_tmp/tmp.<args>

nnoremap <C-h> :<C-u>help<Space>

nnoremap k gk
nnoremap j gj
vnoremap k gk
vnoremap j gj
nnoremap <C-p> gT
nnoremap <C-n> gt
"foolproof
nnoremap ZQ <Nop>


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
