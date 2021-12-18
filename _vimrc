autocmd filetype markdown set matchpairs+=$:$
autocmd filetype markdown nnoremap ci$ vi$
autocmd filetype markdown xnoremap i$ :<C-u> normal! T$vt$<CR>
autocmd filetype markdown onoremap i$ :normal vi$<CR>
autocmd filetype markdown nnoremap a$ va$
autocmd filetype markdown xnoremap a$ :<C-u> normal!F$vf$<CR>
autocmd filetype markdown onoremap a$ :normal va$<CR>
call plug#begin('~/vimfiles/plugged')
Plug 'vim-syntastic/syntastic'
Plug 'gruvbox-community/gruvbox'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'vim-airline/vim-airline'
Plug 'Youssef-Rachad/Vim_easy_predict'
Plug 'mattn/emmet-vim'
Plug 'lervag/vimtex'
Plug 'mechatroner/rainbow_csv'
Plug 'chrisbra/Colorizer'
call plug#end()
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
set notermguicolors
hi Terminal ctermbg=none
hi Normal ctermfg=255 ctermbg=NONE guifg=#ffffff guibg=NONE guisp=NONE cterm=NONE gui=NONE
 hi Terminal ctermfg=255 ctermbg=NONE guifg=#ffffff guibg=NONE guisp=NONE cterm=NONE gui=NONE
let g:markdown_fenced_languages = ['vim']
"Basic
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
"cd $HOME
let mapleader = ' '
filetype plugin on
set encoding=utf-8
set wildmenu "display completion in status line

set clipboard=unnamed "copying into * (system) register always

set ruler "show cursor position always
set showcmd "display incomplete commands
syntax on

"---VISUAL SETTINGS---"
set termguicolors
set background=dark
"let g:airline_theme = 'gruvbox'
let g:airline_theme = 'challenger_deep'
set guifont=DejaVu_Sans_Mono:h12:cANSI
set noerrorbells
set visualbell t_vb=
set colorcolumn=80
set signcolumn=yes
"colorscheme gruvbox
"let g:gruvbox_contrast_dark = 'soft'
colorscheme challenger_deep
"hi Normal guibg=NONE ctermbg=NONE
autocmd InsertEnter * set nocursorline " Change Color when entering Insert Mode
autocmd InsertLeave * set nocursorline " Revert Color to default when leaving Insert Mode

set number
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

"tabs are set and expanded to 4 spaces
set tabstop=4 softtabstop=4 shiftwidth=4
set expandtab autoindent smartindent
set backspace=start,eol,indent

"noo extra files
set noswapfile nobackup noundofile

set incsearch nohlsearch

"completion Settings
set shortmess+=c
set complete-=t
set complete-=i
au BufNewFile,BufRead,BufEnter * setlocal omnifunc=syntaxcomplete#Complete
au filetype * execute 'setlocal dict+=~/vimfiles/dictionnaries/'.&filetype.'.txt'

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

nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>

nnoremap k gk
nnoremap j gj
"---TERMINAL---"
tnoremap <ESC> <c-w>N
nnoremap <leader>t :vsp<CR>:term<CR>

"---NETRW FILE TREE---"
let g:netrw_winsize = 25
let g:netrw_banner=0 "disable annoying banners
"let g:netrw_browse_split=3
let g:netrw_altv=1 "open splits to the right
let g:netrw_liststyle=3 "tree view
"hiding files
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
"<CR>/v/t to open in an h-split/v-split/tab

"nnoremap <F2> :vertical split<bar>vertical resize 25<bar>e .<CR>
nnoremap <F2> :cd %:p:h/<CR>:Lexplore<CR>

function! CreateInPreview()
    let l:filename = input("Filename: ")
    execute 'silent !type '.expand('$HOME').'\vimfiles\skeletons\skeleton.'.split(l:filename, '\.')[1].' > '.b:netrw_curdir.'/'.l:filename
    redraw
endf
autocmd filetype netrw nnoremap <buffer>% :call CreateInPreview()<cr>
"function! Netrw_mappings()
"noremap <buffer>% :call CreateInPreview()<cr>
"endfunction
"autocmd filetype netrw call Netrw_mappings()

"---VIM---"
autocmd Filetype vim nnoremap <F9> :w<bar>source%<bar><CR>:echo'SOURCED!'<CR>
autocmd filetype vim nnoremap <C-C> :s/^\(\s*\)/\1"<CR> :s/^\(\s*\)""/\1<CR> $
"---C PLUS PLUS---"
"this is for commenting and un commenting
"1.	replace beginning of line with with a //
"2. remove // if at beginning of line
augroup CPP
    autocmd filetype cpp nnoremap <C-C> :s/^\(\s*\)/\1\/\/<CR> :s/^\(\s*\)\/\/\/\//\1<CR> $
    autocmd BufNewFile *.cpp 0r $HOME/vimfiles/skeletons/skeleton.cpp
    autocmd filetype cpp nnoremap <F9> :w<bar>!g++ -std=c++14 % -o %:r.out -D _DEBUG -Wl,--stack,268435456<CR>
    autocmd filetype cpp nnoremap <F10> :!%:r.out<CR>
augroup END
"---The C Programming Language---"
augroup C
    autocmd BufNewFile *.c 0r $HOME/vimfiles/skeletons/skeleton.c
    autocmd filetype c nnoremap <C-C> :s/^\(\s*\)/\1\/\/<CR> :s/^\(\s*\)\/\/\/\//\1<CR> $
    autocmd filetype c nnoremap <F9> :w<bar>!gcc % -o %:p:r.out<CR>
    autocmd filetype c nnoremap <F10> :w<bar>!%:p:r.out<CR>
    autocmd Filetype c setlocal iskeyword+=#
augroup END
"---PYTHON---"
augroup PYTHON
    autocmd!
    autocmd filetype python nnoremap <C-C> :s/^\(\s*\)/\1#<CR> :s/^\(\s*\)##/\1<CR> $
    autocmd filetype python xnoremap <C-C> :echo "boi"<CR>
    autocmd filetype python nnoremap <F9> :w<CR>
    autocmd filetype python nnoremap <F10> :w <bar> !python %:p<CR>
augroup END
"---WEB DEVELOPMENT---"
"emmet for html
"let g:user_emmet_mode='a'
let g:user_emmet_leader_key='¿'
augroup JAVASCRIPT
    autocmd filetype javascript nnoremap <C-C> :s/^\(\s*\)/\1\/\/<CR> :s/^\(\s*\)\/\/\/\//\1<CR> $
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd filetype html silent nnoremap <F10> :!firefox file:///%:p<CR>
    autocmd filetype markdown  silent nnoremap <F10> :!firefox file:///%:p<CR>
augroup END
function! Pandoc()
    execute 'silent !pandoc '.expand("%").' -f markdown -t latex -s -o'.expand("%:r").'.tex'
    execute '!pdflatex '.expand("%:r").'.tex'
endfun
":%s/.\{2}$//} --> delete 2 chars

augroup PHP
    autocmd filetype php nnoremap <C-C> :s/^\(\s*\)/\1\/\/<CR> :s/^\(\s*\)\/\/\/\//\1<CR> $
    autocmd filetype php silent nnoremap <F10> :!firefox https://localhost<CR>
    autocmd FileType php setlocal autoindent
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



set statusline+=%F
set statusline+="%:p:h
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"let g:airline_powerline_fonts = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_go_checkers = ['go', 'gofmt', 'govet']
let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_c_checkers = ['gcc']
let g:syntastic_java_checkers = ['checkstyle']
let g:syntastic_java_checkstyle_classpath = '$HOME/vimfiles/java/checkstyle-8.4-all.jar'
let g:syntastic_java_checkstyle_conf_file = '$HOME/vimfiles/java/checkstyle.xml'
let g:syntastic_tex_checkers = []

"---LaTeX---"
"autocmd filetype tex set shellslash
"autocmd filetype tex set sw=2
"autocmd filetype tex set iskeyword+=:
autocmd BufNewFile *.tex 0r $HOME/vimfiles/skeletons/skeleton.tex| execute "normal! 34gg"
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0
autocmd filetype tex set conceallevel=1
autocmd filetype tex nnoremap <F9> :!pdflatex %<CR>
let g:tex_conceal='abdmg'
autocmd filetype tex inoremap \sec \section{}<Left>
autocmd filetype tex inoremap \se* \section*{}<Left>
autocmd filetype tex inoremap \beg \begin{}<CR>\end{}<Up><Left>
autocmd filetype tex inoremap $ $$<Left>
" Latex specification
au BufNewFile,BufRead *.tex
    \ set nocursorline |
    \ set nornu |
    \ set number |
    \ let g:loaded_matchparen=1 |
"---EXPERIMENTAL---"

fun! CODE()
    cd $HOME/code/.
    :Lexplore
endfun
fun! LATEX()
    cd $HOME/code/latex/.
    :Lexplore
endfun
fun! DE()
    cd ~/deutsch/.
    execute 'e ~/deutsch/'.strftime('%Y_%m_%d').'.md'
endfun

au! BufNewFile,BufFilePre,BufRead *.md set makeprg=pandoc\ %\ -o\ %:r.pdf
"au! BufNewFile,BufFilePre,BufRead *.md set makeprg=pandoc\ %\ -o\ %:r.pdf\ -V\ geometry=margin=1in\ -H\ ~/Documents/pandoc_format.tex

