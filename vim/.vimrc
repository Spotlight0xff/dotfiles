" Ultimate .vimrc 


"""
""" ==> GENERAL
"""

execute pathogen#infect()

" start nerdtree if no files are specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" start nerdtree with ctrl-n
map <C-n> :NERDTreeToggle<cr>

let g:NERDCustomDelimiters = {'c': { 'left': '//','rightAlt': '*/', 'leftAlt': '/*' },
            \ 'cuda':{'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'}}

" disable arrow keys (ACHIEVE MASSIVE SPEED)
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>


" show taglist with <leader>tl
map <C-l> :TlistToggle<cr>
let g:Tlist_GainFocus_On_ToggleOpen = 1
let g:Tlist_Close_On_Select = 1
let g:Tlist_Process_File_Always = 1

" lines of history
set history=1000

" enable line numbering
set number

" automatically remove preview window
" If you prefer the Omni-Completion tip window to close when a selection is
" " made, these lines close it on movement in insert mode or when leaving
" " insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" enable filetype plugins
filetype plugin on
filetype indent on

" enable autoread, detect when a file is changed
set autoread

" set , as mapleader to use shortcuts
let mapleader = ","
let g:mapleader = ","

" fast saving
nmap <leader>x :x<cr>
nmap <leader>w :w!<cr>
nmap <leader>wq :wq<cr>
nmap <leader>q :q<cr>

map <F2> :nohlsearch<cr>
" avoid esc
imap ,, <Esc>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Syntastic
let g:syntastic_cpp_check_header = 1
"let g:syntastic_haskell_ghc_mod_exec = 'ghc-mod.sh'
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

" collects ctags
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_key_list_previous_completion=['<Up>']

"" Ultisnips
let g:UltiSnipsExpandTrigger="<c-right>"
let g:UltiSnipsListSnippets="<c-s-space>"

" use auto-ctags
let g:auto_ctags=1
let g:auto_ctags_directory_list = ['.git', '.svn']
let g:auto_ctags_tags_name = 'tags'
let g:auto_ctags_tags_args = '--tag-relative --recurse --sort=yes'
let g:auto_ctags_filetype_mode = 1

" slow multiple_cursors &amp; YCM
function! Multiple_cursors_before()
    let g:ycm_auto_trigger = 0
endfunction
      
function! Multiple_cursors_after()
    let g:ycm_auto_trigger = 1
endfunction

"""
""" ==> VIM User interface
"""

" set 7 lines to the cursor - when moving vertically using jk
set so=7

" Turn on the wild menu (command completition, vim commands)
set wildmenu

" ignore compiled files
set wildignore=*.o,*~,*.pyc

" always show current pos
set ruler

" height of the cmd bar
set cmdheight=2

" a buffer becomes hidden when it is abandoned
set hid

" configure backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" ignore case while searching
set ignorecase

" try to be smart about cases
set smartcase

" highlight search results
set hlsearch

" make search incremental (like in browsers)
set incsearch

" don't redraw while executing macros
set lazyredraw

" for regular expr turn magic on
set magic

" don't show matching brackets when text indicator is over them (Omnisharp suggestion)
set noshowmatch

" how many tenths of a second to blink when matchin brackets
set mat=2

" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"""
""" ==> Colors and Fonts
"""

" enable syntax highlighting
syntax enable

colorscheme desert
" hi Normal ctermbg=none
" set background=none

" set utf8 as standard encoding
set encoding=utf8
set fileencodings=utf-8
" use unix as the standard file type
set ffs=unix,dos,mac



"""
""" ==> Text, tab & indent related
"""

" use spaces instead of tabs
set expandtab

" be smart using tabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" linebreak on 500 characters
set lbr
set tw=500

set ai " auto indent
set si " smart indent
set wrap " wrap lines

"""
""" ==> Visual mode
"""

" in visual mode pressing + or # searches for the current selection
vnoremap <silent> + :call VisualSelection('f')<cr>
vnoremap <silent> # :call VisualSelection('b')<cr>

"""
""" ==> Moving around (tabs, windows, ...)
"""

" thread long lines as break lines
map j gj
map k gk

" map <Space> to / (search) & Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" move between tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>.  :tabprevious<cr>
map <leader>-  :tabnext<cr>
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" use F4 to compile code
" :command Compile :! make; echo $?
fun! SetMkfile()
  let filemk = "Makefile"
  let pathmk = "./"
  let depth = 1
  while depth < 4
    if filereadable(pathmk . filemk)
      return pathmk
    endif
    let depth += 1
    let pathmk = "../" . pathmk
  endwhile
  return "."
endf
let g:compiler_gcc_ignore_unmatched_lines = 1
command! -nargs=* Make | let $mkpath = SetMkfile() | make <args> -C $mkpath | cwindow 3
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" detect cuda as cuda + c++ (to make ycm work)
autocmd FileType cuda set ft=cuda.c



map <F3> :Make <CR>
map <F4> :Make clean <CR>
map <F5> :cnext <CR>
map <F6> :cprevious <CR>
map <F7> :cclose <CR>

"""
""" ==> Status line
"""

" always show the status line (vim-airline)
set laststatus=2
let g:airline_powerline_fonts = 1


" Format the status line
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l




"" helpfer functions
function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction


