call plug#begin('~/.vim/plugged')

Plug 'vim-syntastic/syntastic'
Plug 'morhetz/gruvbox'
call plug#end()
"Basic
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
cd $HOME
let mapleader = ' '
filetype plugin on
set encoding=utf-8
set wildmenu "display completion in status line
"copying into * (system) register always
set clipboard=unnamed

set ruler "show cursor position always
set showcmd "display incomplete commands
syntax on

"---VISUAL SETTINGS---"
set termguicolors
set background=dark
let g:airline_theme = 'gruvbox'
set guifont=DejaVu_Sans_Mono:h12:cANSI
set noerrorbells
set visualbell t_vb=
set colorcolumn=50
set signcolumn=yes
set statusline+=%F
set statusline+="%:p:h
colorscheme gruvbox

set nu "line nums
"relative nums only when typing
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set rnu
    autocmd BufLeave,FocusLost,InsertEnter * set nornu
augroup END

"tabs are set and expanded to 4 spaces
set tabstop=4 softtabstop=4 shiftwidth=4
set expandtab
set autoindent smartindent
set backspace=start,eol,indent

"noo extra files
set noswapfile
set nobackup
set noundofile

set incsearch
set nohlsearch

"completion Settings
set complete+=k
"autocmd FileType java setlocal omnifunc=javacomplete#Complete

"typing shorts
inoremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
inoremap {{ {
inoremap {} {}

inoremap [ []<Left>
inoremap [<CR> [<CR>]<Esc>O
inoremap [[ [
inoremap [] []

inoremap ( ()<Left>
inoremap ' ''<Left>
inoremap " ""<Left>

inoremap (( (
inoremap () ()
inoremap '' '
inoremap "" "

map <leader>h :wincmd h<CR>
map <leader>j :wincmd j<CR>
map <leader>k :wincmd k<CR>
map <leader>l :wincmd l<CR>

nnoremap <silent> <leader>v+ :vertical resize +5<CR>
nnoremap <silent> <leader>v- :vertical resize -5<CR>
"---NETRW FILE TREE---"
let g:netrw_winsize = 25
let g:netrw_banner=0 "disable annoying banners
let g:netrw_browse_split=2 "open in prior window
let g:netrw_altv=1 "open splits to the right
let g:netrw_liststyle=3 "tree view
"hiding files
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
"allows to open explorer in :edit
"<CR>/v/t to open in an h-split/v-split/tab
"check |netrw-browse-maps| for more mappings

"nnoremap <F2> :vertical split<bar>vertical resize 25<bar>e .<CR>
nnoremap <F2> :Lexplore<CR>
"---VIM---"
autocmd Filetype vim nnoremap <F9> :w<bar>source%<bar><CR>:echo'SOURCED!'<CR>
"---C PLUS PLUS---"
"this is for commenting and un commenting
"1.	substitute, at the beginning of the line.any white-space character,with a //
"2. reverse if // is at beginning of line
"3. goto eol
augroup CPP
    autocmd filetype cpp nnoremap <C-C> :s/^\(\s*\)/\1\/\/<CR> :s/^\(\s*\)\/\/\/\//\1<CR> $
    autocmd BufNewFile *.cpp 0r $HOME/vimfiles/skeleton.cpp
    autocmd filetype cpp nnoremap <F9> :w<bar>!g++ -std=c++14 % -o %:r.out -Wl,--stack,268435456<CR>
    autocmd filetype cpp nnoremap <F10> :!%:r.out<CR>
augroup END
"---PYTHON---"
augroup PYTHON
    autocmd!
    autocmd filetype python nnoremap <C-C> :s/^\(\s*\)/\1#<CR> :s/^\(\s*\)##/\1<CR> $
    autocmd filetype python xnoremap <C-C> :echo "boi"<CR>
    autocmd filetype python nnoremap <F9> :w<CR>
    autocmd filetype python nnoremap <F10> :w <bar> !python %<CR>
augroup END

"---WEB DEVELOPMENT---"
"emmet for html
"let g:user_emmet_mode='a'

let g:user_emmet_leader_key='¿'
augroup JAVASCRIPT
    autocmd filetype js nnoremap <C-C> :s/^\(\s*\)/\1\/\/<CR> :s/^\(\s*\)\/\/\/\//\1<CR> $
augroup END

fun! IndentSave()
    let save_cursor = getpos(".")
    normal! gg=G
    write
    call setpos('.',save_cursor)
endfun
fun! TrimWhiteSpace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
nnoremap <leader>w :call IndentSave() <CR>:call TrimWhiteSpace()<CR>



set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_java_checkers = ['checkstyle']
let g:syntastic_java_checkstyle_classpath = '$HOME/vimfiles/java/checkstyle-8.4-all.jar'
let g:syntastic_java_checkstyle_conf_file = '$HOME/vimfiles/java/checkstyle.xml'
