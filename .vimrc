"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Shawn Tice, with lots of help from the internet.

set guioptions=aMm       " No toolbar in the gui; must be first in .vimrc.

set nocompatible         " No compatibility with vi.
filetype on              " Recognize syntax by file extension.
filetype indent on       " Check for indent file.
filetype plugin on       " Allow plugins to be loaded by file type.
syntax on                " Syntax highlighting.

set autowrite             " Write before executing the 'make' command.
set background=light      " Background light, so foreground not bold.
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
set scrolloff=10          " Keep min of 10 lines above/below cursor.
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

let loaded_matchparen=1   " Don't do automatic bracket highlighting.
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

" Execute an :lcd to the directory of the file being edited.
function LcdToCurrent()
    let dir = expand("%:h")
    execute "lcd " . dir
endfunction
noremap <Leader>cd :call LcdToCurrent()<CR>

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlighting

syntax enable
set background=light
colorscheme solarized

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
  autocmd BufWritePost vimrc          so ~/.vimrc
augroup END
" }}}
