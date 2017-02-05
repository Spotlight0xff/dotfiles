" Ultimate .vimrc 


"""
""" ==> PLUGINS
"""

call plug#begin('~/.vim/plugged')

" Plugin list
Plug 'scrooloose/nerdcommenter' " https://github.com/scrooloose/nerdcommenter
Plug 'scrooloose/nerdtree' " https://github.com/scrooloose/nerdtree
"Plug 'tpope/vim-fugitive' " https://github.com/tpope/vim-fugitive
"Plug 'tpope/vim-surround' " https://github.com/tpope/vim-surround
Plug 'justinmk/vim-sneak' " https://github.com/justinmk/vim-sneak
Plug 'skywind3000/asyncrun.vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' } " https://github.com/Valloric/YouCompleteMe
"Plug 'SirVer/ultisnips' " https://github.com/SirVer/ultisnips
"Plug 'honza/vim-snippets' " https://github.com/honza/vim-snippets
"Plug 'ctrlpvim/ctrlp.vim' " https://github.com/ctrlpvim/ctrlp.vim
Plug 'vim-airline/vim-airline' " https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline-themes' " https://github.com/vim-airline/vim-airline-themes
Plug 'airblade/vim-gitgutter' " https://github.com/airblade/vim-gitgutter
Plug 'benekastah/neomake' " https://github.com/benekastah/neomake
"Plug 'xolox/vim-easytags' " https://github.com/xolox/vim-easytags
"Plug 'xolox/vim-misc' " https://github.com/xolox/vim-misc
Plug 'vim-scripts/taglist.vim' " https://github.com/vim-scripts/taglist.vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'jalcine/cmake.vim' " https://github.com/jalcine/cmake.vim

"Plug 'editorconfig/editorconfig-vim' " https://github.com/editorconfig/editorconfig-vim
Plug 'tikhomirov/vim-glsl'

call plug#end()


let g:easytags_file = '~/.vim/tags'
"let g:easytags_autorecurse = 1
let g:easytags_cmd = '/usr/bin/ctags'
let g:easytags_async = 1
let g:easytags_dynamic_files = 1
let g:easytags_always_enabled = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_confirm_extra_conf = 0


let g:neomake_cpp_clang_args = ['-x', '-std=c++14', '-Weverything', '-Wformat', '-fsyntax-only', '-iquoteinclude/', '-Wformat-security', '-Wno-shadow']


"" disable indentation in python files on comments
autocmd BufRead *.py inoremap # X<c-h>#<space>



"" ==> NERDTree
" start nerdtree if no files are specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" start nerdtree with ctrl-n
map <C-n> :NERDTreeToggle<cr>


"" ==> NERDCommenter
let g:NERDCustomDelimiters = {
      \'c': { 'left': '//','rightAlt': '*/', 'leftAlt': '/*' },
      \'glsl': { 'left': '//','rightAlt': '*/', 'leftAlt': '/*' },
      \'cuda':{'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'}}

"" ==> vim-taglist
" show taglist with <leader>tl
map <C-l> :TlistToggle<cr>

" self-explanatory settings
let g:Tlist_GainFocus_On_ToggleOpen = 1
let g:Tlist_Close_On_Select = 1
let g:Tlist_Process_File_Always = 1

"" ==> Ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"" ==> YouCompleteMe
" collects ctags
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
" use ultisnips
let g:ycm_use_ultisnips_completer = 1


"" disable completion for latex etc.
let g:ycm_filetype_blacklist = {
    \ 'gitcommit': 1,
    \ 'latex': 1,
    \ 'tex': 1
    \}


" slow multiple_cursors &amp; YCM
"function! Multiple_cursors_before()
    "let g:ycm_auto_trigger = 0
"endfunction
      
"function! Multiple_cursors_after()
    "let g:ycm_auto_trigger = 1
"endfunction

"""
""" ==> GENERAL
"""


" lines of history
set history=1000

" enable line numbering
set relativenumber
set number


" automatically remove preview window
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


map <S-F2> :nohlsearch<cr>

" avoid esc
imap ,, <Esc>

"" write one char (insert/append) in normal mode
":nnoremap s :exec "normal i".nr2char(getchar())."\e"<CR>
":nnoremap S :exec "normal a".nr2char(getchar())."\e"<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

function! AddItem()
    if searchpair('\\begin{itemize}', '', '\\end{itemize}', 'W')
        return "\\item "
    else
        return ""
    endif
endfunction

inoremap <expr><buffer> <CR> "\r".AddItem()
nnoremap <expr><buffer> o "o".AddItem()
nnoremap <expr><buffer> O "O".AddItem()

"" disable indentation for items in itemized env
let g:tex_indent_items=0


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
set cmdheight=1

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
highlight LineNr ctermfg=grey

" set utf8 as standard encoding (for default-vim)
if !has('nvim')
  set encoding=utf8
  set fileencodings=utf-8
endif
" use unix as the standard file type
set ffs=unix,dos,mac



"""
""" ==> Text, tab & indent related
"""

" use spaces instead of tabs
set expandtab

" be smart using tabs
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" no namespace indentation
set cino=N-s,g1,h1

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

" set cursor pos to first line
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])




nnoremap <expr> <silent> <F3>   (&diff ? "]c" : ":cnext\<CR>")
nnoremap <expr> <silent> <S-F3> (&diff ? "[c" : ":cprev\<CR>")
map <F5> :Make <CR>
map <F7> :cclose <CR>

"""
""" ==> Status line
"""

"" ==> vim-airline
" always show the status line
set laststatus=2
let g:airline_theme = 'base16_default'
let g:airline_powerline_fonts = 1

"" ==> vim-airline (tabline)
"let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0



"" helper functions
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
nnoremap <leader>jj :YcmCompleter GoTo<CR>
set clipboard+=unnamedplus

fun! LNext(prev)
    try
        try
            if a:prev | lprev | else | lnext | endif
        catch /^Vim\%((\a\+)\)\=:E553/
            if a:prev | llast | else | lfirst | endif
        catch /^Vim\%((\a\+)\)\=:E776/
        endtry
    catch /^Vim\%((\a\+)\)\=:E42/
    endtry
endfun

nnoremap <silent> <F1> :call LNext(1)<CR>
nnoremap <silent> <F2> :call LNext(0)<CR>

nnoremap <silent> <c-w>z :wincmd z<cr>:cclose<cr>:lclose<cr>


augroup QuickfixStatus
  au! BufWinEnter quickfix setlocal 
        \ statusline=%t\ [%{g:asyncrun_status}]\ %{exists('w:quickfix_title')?\ '\ '.w:quickfix_title\ :\ ''}\ %=%-15(%l,%c%V%)\ %P
augroup END

let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])



set splitbelow
" automatically open qfix
augroup MyGroup
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
augroup END

"nnoremap <F5> :AsyncRun -post=:clist<bar>:silent\ !notify-send\ -u\ critical\ 'Compilation\ done' make<CR>
nnoremap <F5> :AsyncRun -cwd=build -post=:clist make<cr>
nnoremap <F6> :split term://./run.sh; i3-msg 'workspace back_and_forth'<cr>

" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  let myUndoDir = expand(vimDir . '/undodir')
  " Create dirs
  call system('mkdir ' . vimDir)
  call system('mkdir ' . myUndoDir)
  let &undodir = myUndoDir
  set undofile
endif
