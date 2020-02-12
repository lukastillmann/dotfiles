" Lukas Tillmann

" /* Base Options {{{1 */

set ruler
set number

set autoindent
set ai

set nospell                         " disable spell-checking

set foldmethod=indent
set foldnestmax=10
set foldlevelstart=10

set shiftwidth=3
set tabstop=3
set expandtab

set cursorline                      " highlight the current line

set wildmenu                        " graphical autocomplete menu for files

set hlsearch                        " highlight search results
set incsearch                       " search as characters are entered
set ignorecase                      " ignore case when searching

set showmatch                       " show matching brackets

let mapleader = ","

set modelines=1                     " check first and last line for file specific configs

set exrc                            " allow project specific .vimrc files
set secure                          " disable unsave commands in project vimrc

set backspace=2                     " make backspace work like other programs

" set termguicolors                   " use truecolor

set omnifunc=syntaxcomplete#Complete

set clipboard=unnamedplus           " use windows clipboard from wsl, does not seem to work though 
let g:loaded_clipboard_provider = 1 " fixes clipboard errors in neovim

" enable yanking to windows clipboard
if has('wsl')
  augroup Yank
    autocmd!
    autocmd TextYankPost * :call system('clip.exe ',@")
  augroup END
endif

set nofixendofline                  " to prevent 'no end of line' warnings in git diff

set visualbell                      " disable beep sounds
set t_vb=                           " If 't_vb' is cleared and 'visualbell' is set, no beep and no flash will ever occur



" /* Plugins {{{1 */

" install vim-plug if not installed yet
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Editor
Plug 'vim-airline/vim-airline'			         	" status/tabline
Plug 'morhetz/gruvbox'				                  " vim theme
Plug 'kshenoy/vim-signature'				            " toggle/display/navigate marks
" Plug 'embear/vim-localvimrc'				         " enables .lvimrc files in project folders
Plug 'honza/vim-snippets'                          " adds snippets

" Coding Shortcuts
Plug 'neoclide/coc.nvim', {'branch': 'release'}		" Intellisense (autocompletion) engine
" Plug 'prettier/vim-prettier'
Plug 'preservim/nerdcommenter'				         " comment functions

" File Management
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'			         " show git status of files in nerdtree window
Plug 'junegunn/fzf', { 'do': './install --bin' }	" fuzzy finding of files
Plug 'junegunn/fzf.vim'					               " is also needed for fzf

" Git Extensions
Plug 'airblade/vim-gitgutter' 				         "  
Plug 'tpope/vim-fugitive'				               " git wrapper for vim (e.g. :Gblame etc)

" Syntax Highlighting
Plug 'sheerun/vim-polyglot'                        " collection of language packs for more than 100 languages
Plug 'ap/vim-css-color'					               " color previews in css

" Tmux
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" /* Colors {{{1 */
syntax enable
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark
" }}}
" /* Mappings {{{1 */

nnoremap <silent> <leader>, :noh<cr> " Stop highlight after searching
imap <C-c> <CR><Esc>O       " mapping to split lines (e.g. between brackets)

" double dashes to toggle comments (with vim-commentary plugin)
" map // gcc
map // <leader>c<space>

" apply macros with Q
" hit qq to record, q to stop recording, and Q to apply.
nnoremap Q @q
vnoremap Q :norm @q<cr>

set pastetoggle=<leader>z " toggle paste mode with leader-z

map <C-n> :NERDTreeToggle<CR>

" increment/decrement number with Alt-a/Alt-x
" because Ctrl-a is used by tmux
:nnoremap <A-a> <C-a>
:nnoremap <A-x> <C-x>

" add new line after opening brackets
" see https://stackoverflow.com/a/35711195/5888924
inoremap <expr> <cr> getline(".")[col(".")-2:col(".")-1]=="{}" ? "<cr><esc>O" : "<cr>"

" copy to windows clipboard
map <C-c> :w !clip.exe<CR><CR>

" reset syntax highlighting in vue files
nnoremap <C-s> :syntax sync fromstart<CR>
" set autocommand for this, may have performance issues, try out later
autocmd FileType vue syntax sync fromstart



" /* Pane Handling / Tmux {{{1 */

" switching between panes
" taken over by vim-tmux-navigator
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

" resize panes with arrow keys
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

" Auto resize Vim splits to active split
set winwidth=104
set winheight=5
set winminheight=5
autocmd WinEnter * wincmd _

" split new panes left/down/up/right
nnoremap <C-W><C-J> <C-W>s<C-W><C-J>
nnoremap <C-W><C-K> <C-W>s<C-W><C-K>
nnoremap <C-W><C-L> <C-W>v<C-W><C-L>
nnoremap <C-W><C-H> <C-W>v<C-W><C-H>

" /* Buffer/Saving {{{1 */

" Starting from vim 7.3 undo can be persisted across sessions
" http://www.reddit.com/r/vim/comments/kz84u/what_are_some_simple_yet_mindblowing_tweaks_to/c2onmqe
if has("persistent_undo")
	set undodir=~/.vim/undodir
	set undofile
endif

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" Reload changes to .vimrc automatically
autocmd BufWritePost  ~/.vimrc source ~/.vimrc

" deactivate safe write
set backupcopy=yes

" /* Syntastic {{{1 */
" npm install -g csslint jshint jsonlint
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0 " Don't auto open/close location list
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
" let g:syntastic_mode="passive"
" let g:syntastic_enable_signs=0
let g:syntastic_css_checkers = ['csslint']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_json_checkers= ['jsonlint']
let g:syntastic_quiet_messages = { "level": "warnings" }

nnoremap <F7> :SyntasticCheck<CR> :lopen<CR>

" /* COC {{{1 */

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB> 
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
   let col = col('.') - 1
   return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-json', 
  \ 'coc-vetur',
  \ 'coc-html',
  \ 'coc-prettier',
  \ 'coc-eslint'
  \ ]

" from readme
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup 
" Better display for messages 
set cmdheight=2 
set previewheight=50
au BufEnter ?* call PreviewHeightWorkAround()
func PreviewHeightWorkAround()
    if &previewwindow
        exec 'setlocal winheight='.&previewheight
    endif
endfunc

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" Use <cr> (enter) to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" make <cr>/enter select the first item, if no item has been selected.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" /* Prettier {{{1 */
"let g:prettier#config#bracket_spacing = 'true'
"let g:prettier#config#semi = 'true'
"let g:prettier#config#jsx_bracket_same_line = 'false'
"let g:prettier#config#single_quote = 'true'
"let g:prettier#config#tab_width = 3
"let g:prettier#config#html_whitespace_sensitivity = 'ignore'
" use F9 to trigger Prettier

" coc-prettier config
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nnoremap <F9> :Prettier<CR>

" map <leader>-f to format a range
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" /* NERDCommenter {{{1 */

" enable NERDCommenter in vue files
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction

" /* Misc plugin configuration {{{1 */

" vim-jsx configuration
let g:jsx_ext_required = 0                         " faster syntax highlighting in vue files
let g:vue_disable_pre_processors = 1
let g:localvimrc_whitelist=['/home/lukas" /*']


" /* Misc {{{1 */

" javascript syntax for helma hac files and vue
autocmd BufNewFile,BufRead *.hac set filetype=javascript
autocmd BufNewFile,BufRead *.skin set filetype=html

" /* Custom Functions {{{1 */
" Functions to remove all gutters (used for tmux copy function)
nnoremap <F3> :call RemoveGutter()<CR>
nnoremap <F4> :call AddGutter()<CR>

function! RemoveGutter()
  execute "set nonumber"
  execute "GitGutterDisable"
endfunction
function! AddGutter()
  execute "set number"
  execute "GitGutterEnable"
endfunction

" /* Often used commands {{{1 */
" <C-W>R - swap splits


" }}}

" vim:foldmethod=marker:foldlevel=0
