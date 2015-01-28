" First things first...
set nocompatible
set encoding=utf-8

" Other first things second
execute pathogen#infect()

" Even more otherish first things third
set t_Co=256
syntax on
filetype plugin indent on

"==============================================================================
" Fix up some key mappings
"==============================================================================
" Who uses "\" ?
let mapleader = ","
" These should be defaults...
noremap ' `
noremap ` '
" Lines and wrap and whitespace visibility are sometimes good
nnoremap <leader>l :set invnumber<CR>
nnoremap <leader>w :set invwrap<CR>
nnoremap <leader>s :set invhls<CR>
nnoremap <leader>h :set invlist<CR>
" Shift space exits insert/visual select
inoremap <S-Space> <Esc>
vnoremap <S-Space> <ESC>
" Make Y work like D and C
nnoremap <S-y> y$
" Enter a blank line below/above cursor in Normal mode.
nmap ,o o<Esc>k
nmap ,O O<Esc>j
" Map better window nav
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-H> <C-W>h
" Search stuff
nnoremap <leader>a :Ggrep 
autocmd QuickFixCmdPost *grep* cwindow
" Close a window panel
nmap <leader>c <C-w>c
" Use <leader>v to open a new vertical split and switch to it
nnoremap <leader>v <C-w>v<C-w>l
" Let's make it easy to edit/source this file
nmap <silent> <leader>ev :e $MYVIMRC<cr>
nmap <silent> <leader>sv :so $MYVIMRC<cr>
" Make/cd to the directory that contains the file in the current buffer.
" This is useful when you edit a file in a directory that doesn't
" (yet) exist
nmap  <leader>md :!mkdir -p %:p:h
nmap <leader>cd :lcd %:h<CR>
" Arrow keys are evil, discourage usage...
noremap <Up> <ESC>
noremap <Down> <ESC>
noremap <Left> <ESC>
noremap <Right> <ESC>
" Navigate visible lines, not physical lines
nnoremap j gj
nnoremap k gk
 " :W saves with sudo
command! W w !sudo tee % > /dev/null
" Speed up git commands
nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit<CR>
" Bubble text with unimpared
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv
" Switch between buffers
noremap <tab> :bn<CR>
noremap <S-tab> :bp<CR>
" Delete buffers faster
nmap <leader>d :BD<CR>
nmap <leader>D :bufdo bd<CR>
" Make space useful in normal mode...
nmap <Space> /
" Groupings are good, make it easy to add them when building regex


cmap <leader>\ \(\)<Left><Left>
"un-neuter Command-T
nmap <leader>t :CommandT<CR>
" Navigate visible lines, not physical lines
nnoremap j gj
nnoremap k gk

"==============================================================================
" Set up vim window
"==============================================================================
set relativenumber          " Not sure about this.....
set number                  " I like linenumbers
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

set showmode                " At least let yourself know what mode you're in
set showcmd                 " Show the current command in the lower right corner
set ch=2                    " Make command line two lines high
set bg=dark                 " Tell Vim we want the defaults for a dark bg
colorscheme railscasts      " Set up a decent theme
set scrolloff=8             " Keep the cursor 8 lines from the top and bottom
set cursorline              " highlight current line
if has("statusline") && !&cp
  set laststatus=2              " always show the status bar
  set statusline=%f\ %m\ %r     " filename, modified, readonly
  set statusline+=%{fugitive#statusline()}
  set statusline+=\ %l/%L[%p%%] " current line/total lines
  set statusline+=\ %v[0x%B]    " current column [hex char]
endif

"==============================================================================
" Set up non-standard vim settings
"==============================================================================
set autoread                " Don't bug us when git updates our files, just read them again

" Search
set nohlsearch              " no highlighting search
set incsearch               " incremental searching
set ignorecase              " searches are case insensitive...
set smartcase               " ... unless they contain at least one capital letter
set gdefault                " have :s///g flag by default on

" Yank to system clipboard
set clipboard=unnamed

" Whitespace
set tabstop=2
set shiftwidth=2
set expandtab
set list                      " show shitespace
set listchars=tab:»·,trail:·  " better whitewpace
set autoindent

set history=100                    " Keep some stuff in the history
set synmaxcol=800                  " Syntax coloring lines that are too long just slows down the world

"Select All should use visual select, not select mode
noremenu  20.400 &Edit.&Select\ All<Tab>ggVG    ggVG
inoremenu 20.400 &Edit.&Select\ All<Tab>ggVG    <Esc>ggVG
cnoremenu 20.400 &Edit.&Select\ All<Tab>ggVG    <Esc>ggVG

set mousehide                      " Hide the mouse pointer while typing
set hidden                         " This should be default...

" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

set backspace=2                    " Allow backspacing over indent, eol, and the start of an insert
set whichwrap=b,s,h,l,<,>,[,]      " Same with navigation
set shortmess+=filmnrxoOtT         " abbrev. of messages (avoids 'hit enter')

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=100

"folding settings
set foldmethod=syntax
set foldnestmax=10
set nofoldenable        "dont fold by default
" toggle the current fold
:nnoremap <Space> za

" In command-line mode, C-a jumps to beginning (to match C-e)
cnoremap <C-a> <Home>

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches"
set wildignore+=bundle/**,vendor/bundle/**,vendor/cache/** " ignore Bundler standalone/vendor installs & gems
set wildignore+=node_modules/**

set splitright
set splitbelow
