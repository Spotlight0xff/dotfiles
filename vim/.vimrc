" vim: set fdm=manual
" Ultimate .vimrc


""" ==> Plugin list

" Install vim-plug:
"
" For Neovim
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" For vim:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.vim/plugged')

""" Plugin list
" helps with writing comments fast
Plug 'scrooloose/nerdcommenter'

" sidebar for files
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

" adds some missing motions for vim
Plug 'justinmk/vim-sneak'

" code completion engines
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }

" snippets engine, integrates into YCM
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" sexy looking statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" handle git in vim directly
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Asynchronous make
Plug 'benekastah/neomake'

" taglist as sidebar window
Plug 'vim-scripts/taglist.vim'

" ctrl-p on steriods
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" asynchronous command execution
Plug 'skywind3000/asyncrun.vim'

" GLSL language support
Plug 'tikhomirov/vim-glsl'

" restore views automatically
Plug 'vim-scripts/restore_view.vim'

""" DISABLED
"Plug 'editorconfig/editorconfig-vim'
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'jalcine/cmake.vim'
"Plug 'xolox/vim-easytags'
"Plug 'xolox/vim-misc'
"Plug 'tpope/vim-surround'

call plug#end()

""" ==> General

" lines of history
set history=1000

" enable both absolute and relative line numbering
set relativenumber
set number

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

" remove search highlights
map <S-F2> :nohlsearch<cr>

" avoid esc
imap ,, <Esc>

""" ==> User interface

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

" Remember info about open buffers on close
set viminfo^=%

" Using ALWAYS clipboard, for all operations
set clipboard+=unnamedplus

" :split below current window
set splitbelow

set viewoptions=cursor,folds,slash,unix

""" ==> Colors and Fonts

" enable syntax highlighting
syntax enable

colorscheme desert
highlight LineNr ctermfg=grey



""" ==> Text, tab & indent related

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


" set utf8 as standard encoding (for default-vim)
if !has('nvim')
  set encoding=utf8
  set fileencodings=utf-8
endif
" use unix as the standard file type
set ffs=unix,dos,mac



""" ==> Navigation in code and windows/tabs

" always status line
set laststatus=2

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

" fold by indent level, but don't open by default
set foldmethod=indent
set nofoldenable


""" ==> Filetype specific hacks

" automatically add \item in latex itemize env
function! AddItem()
    if searchpair('\\begin{itemize}', '', '\\end{itemize}', 'W')
        return "\\item "
    else
        return ""
    endif
endfunction

function! EnableTexItemEnv()
  inoremap <expr><buffer> <CR> "\r".AddItem()
  nnoremap <expr><buffer> o "o".AddItem()
  nnoremap <expr><buffer> O "O".AddItem()
endfunction

" but only if we are in *.tex
autocmd BufNewFile,BufRead *.tex call EnableTexItemEnv()

"-------------------------------------------------------------------

" set cursor pos to first line of git commit
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" detect cuda as cuda + c++ (to make ycm work)
autocmd FileType cuda set ft=cuda.c

" disable indentation in python files on comments
autocmd BufRead *.py inoremap # X<c-h>#<space>


""" ==> Terminal
" :terminal in Neovim
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l


""" ==> Compilation (+Error navigation)
map <F5> :Neomake <CR>

" open quickfix window after make
autocmd QuickFixCmdPost [^l]* nested cwindow

" same for Neomake
let g:neomake_open_list=2

" close any quickfix- or locationlist window
nnoremap <silent> <c-w>z :wincmd z<cr>:cclose<cr>:lclose<cr>

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

nnoremap <silent> ]q :call LNext(1)<CR>
nnoremap <silent> [q :call LNext(0)<CR>
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow




""" ==> Lazy hacks

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
"--------------------------------------------------------------
" automatically remove preview window
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"------------------------------------------------------------------





""" ==> Plugin settings

"" ==> YouCompleteMe
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

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
" Goto using jj
noremap <leader>jj :YcmCompleter GoTo<CR>

"" ==> NeoMake
let g:neomake_cpp_clang_args = ['-x', '-std=c++14', '-Weverything', '-Wformat', '-fsyntax-only', '-iquoteinclude/', '-Wformat-security', '-Wno-shadow']


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
" show taglist with <Ctrl>-L
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

"" ==> AsyncRun.vim
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

augroup MyGroup
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
augroup END

augroup QuickfixStatus
  au! BufWinEnter quickfix setlocal
        \ statusline=%t\ [%{g:asyncrun_status}]\ %{exists('w:quickfix_title')?\ '\ '.w:quickfix_title\ :\ ''}\ %=%-15(%l,%c%V%)\ %P
augroup END

"" ==> vim-airline
" always show the status line
let g:airline_theme = 'base16_default'
let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#neomake#enabled = 1


"" ==> vim-fugitive
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gp :AsyncRun git push<CR>
nnoremap <leader>gpl :AsyncRun git pull<CR>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>


