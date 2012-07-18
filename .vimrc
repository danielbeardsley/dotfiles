" Pathogen vim plugin loading - https://github.com/tpope/vim-pathogen
call pathogen#infect()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Shawn Tice, with lots of help from the internet.

set guioptions=am        " No toolbar in the gui; must be first in .vimrc.
set guifont=Consolas:h9
" encoding settings for gVim
set encoding=utf-8
set fileencoding=utf-8

set nocompatible         " No compatibility with vi.
filetype on              " Recognize syntax by file extension.
filetype indent on       " Check for indent file.
filetype plugin on       " Allow plugins to be loaded by file type.
syntax on                " Syntax highlighting.

set autowrite             " Write before executing the 'make' command.
set background=dark       " Background light, so foreground not bold.
set backspace=2           " Allow <BS> to go past last insert.
set expandtab             " Expand tabs with spaces.
set nofoldenable          " Disable folds; toggle with zi.
set gdefault              " Assume :s uses /g.
set ignorecase            " Ignore case in regular expressions
set incsearch             " Immediately highlight search matches.
set modeline              " Check for a modeline.
set noerrorbells          " No beeps on errors.
set nohls                 " Don't highlight all regex matches.
set nowrap                " Don't soft wrap.
set number                " Display line numbers.
set ruler                 " Display row, column and % of document.
set scrolloff=6           " Keep min of 6 lines above/below cursor.
set shiftwidth=3          " >> and << shift 3 spaces.
set showcmd               " Show partial commands in the status line.
set showmatch             " Show matching () {} etc..
set showmode              " Show current mode.
set smartcase             " Searches are case-sensitive if caps used.
set softtabstop=3         " See spaces as tabs.
set tabstop=3             " <Tab> move three characters.
set textwidth=79          " Hard wrap at 79 characters.
set virtualedit=block     " Allow the cursor to go where there's no char.
set wildmode=longest,list " Tab completion works like bash.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set some configuration variables.

let loaded_matchparen=0   " do automatic bracket highlighting.
let mapleader=","         " Use , instead of \ for the map leader.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Formatting settings

" t: Auto-wrap text using textwidth. (default)
" c: Auto-wrap comments; insert comment leader. (default)
" q: Allow formatting of comments with "gq". (default)
" r: Insert comment leader after hitting <Enter>.
" o: Insert comment leader after hitting 'o' or 'O' in command mode.
" n: Auto-format lists, wrapping to text *after* the list bullet char.
" l: Don't auto-wrap if a line is already longer than textwidth.
set formatoptions+=ronl

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command-line cartography

" Command-line editing more like bash/emacs.
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <C-U> <C-E><C-U>

" Stupid shift mistakes.
:command W w
:command Q q

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command mode cartography

" Make Q reformat text.
noremap Q gq

" Toggle paste mode.
noremap <Leader>p :set paste!<CR>

" Open the file under the cursor in a new tab.
noremap <Leader>ot <C-W>gf

" Toggle highlighting of the last search.
noremap <Leader>h :set hlsearch! hlsearch?<CR>

" Open a scratch buffer.
noremap <Leader>s :Scratch<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Insert mode cartography

" Set up dictionary completion.
set dictionary+=~/.vim/dictionary/english-freq
set complete+=k

" Insert <Tab> or complete identifier if the cursor is after a keyword
" character.
function TabOrComplete()
    let col = col('.')-1
    if !col || getline('.')[col-1] !~ '\k'
        return "\<tab>"
    else
        return "\<C-N>"
     endif
endfunction
inoremap <Tab> <C-R>=TabOrComplete()<CR>

" Make C-s write the buffer and return to insert mode when applicable
inoremap <C-s> <C-O>:w<CR>
nnoremap <C-s> :w<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlighting

syntax enable
" This should automatically be determined from the terminal type...
set t_Co=16
colorscheme solarized

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic options : https://github.com/scrooloose/syntastic/

let g:syntastic_check_on_open=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Restore the cursor when we can.

function! RestoreCursor()
    if line("'\"") <= line("$")
        normal! g`"
        normal! zz
    endif
endfunction
autocmd BufWinEnter * call RestoreCursor()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My Customizations

set path=~/Code/**

" Reread configuration of Vim if .vimrc is saved {{{
augroup VimConfig
  au!
  autocmd BufWritePost ~/.vimrc       so ~/.vimrc
  autocmd BufWritePost _vimrc         so ~/_vimrc
  autocmd BufWritePost vimrc          so ~/.vimrc
augroup END
" }}}

" Since I hardly ever need to type jk this is fast.
imap jk <Esc>
imap kj <Esc>

" Use hjkl in insert mode
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>

" auto-insert second braces and parynthesis
inoremap {<CR> {<CR>}<Esc>O
inoremap ({<CR> ({<CR>});<Esc>O
inoremap <<<<CR> <<<EOT<CR>EOT;<Esc>O<C-TAB><C-TAB><C-TAB>
set cpoptions+=$ "show dollar sign at end of text to be changed

" Allow easy toggling of spaces / tabs mode
nnoremap <C-t><C-t> :set invexpandtab<CR>

"Highlights lines that are greater than 80 columns
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength '\%80v.\+'
set colorcolumn=80

" Create simple toggles for line numbers, paste mode, and word wrap.
nnoremap <C-N><C-N> :set invnumber<CR>
nnoremap <C-p><C-p> :set invpaste<CR>
nnoremap <C-w><C-w> :set invwrap<CR>

" Use C-hjkl in to change windows
nnoremap <C-h> <C-w><Left>
nnoremap <C-j> <C-w><Down>
nnoremap <C-k> <C-w><Up>
nnoremap <C-l> <C-w><Right>


"==========================================
" vim-powerline: https://github.com/Lokaltog/vim-powerline
let g:Powerline_theme="solarized"
let g:Powerline_symbols="compatible"
" show status line even where there is only one window
set laststatus=2

"==========================================
" vim-indent-guides : 
"hi IndentGuidesOdd  ctermbg=black
"hi IndentGuidesEven ctermbg=darkgrey
"hi IndentGuidesOdd  ctermbg=white
"hi IndentGuidesEven ctermbg=lightgrey

"==========================================
" Mouse Options

" Enable mouse scrolling in all modes!
set mouse=a
" Set scrolling to be single-line
:map <MouseDown> <C-Y>
:map <S-MouseDown> <C-U>
:map <MouseUp> <C-E>
:map <S-MouseUp> <C-D>

